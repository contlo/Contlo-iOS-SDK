//
//  ProfileHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

class ProfileHandler {
    static let TAG = "ProfileHandler"
    static let PROFILE_V2 = "/v2/identify"
    static let CONTLO_PROD = "https://api1.contlo.com"
    static let CONTLO_STAGING = "https://api.contlo.in"
    
    private static func getProfileBaseUrl() -> URL {
//        return URL(string: CONTLO_STAGING + PROFILE_V2)!
        return URL(string: CONTLO_PROD + PROFILE_V2)!
    }
    

    static func sendUserData(audience: Audience, isUpdate: Bool, completion: @escaping (String) -> Void) {
        
        let externalId = ContloDefaults.getExternalId()
        let apnsToken = ContloDefaults.getDeviceToken()
        let pushConsent = ContloDefaults.isNotificationEnabled()
        
        let devicePropery = Utils.retrieveUserData()

        audience.setup(externalId: externalId, apnsToken: apnsToken, pushConsent: pushConsent, data: devicePropery)
        sendUserToContlo(audience: audience) {result in
            switch result {
            case .success(_):
                ContloDefaults.setEmail(audience.userEmail ?? nil)
                ContloDefaults.setPhoneNumber(audience.userPhone)
                completion("Succesfully sent user data to Contlo")
                
            case .error(let error):
                completion(error.localizedDescription )
            }
        }
        
    }
    
    static func sendUserToContlo(audience: Audience, completion: @escaping (Resource<String>) -> Void) {
        
        
        let httpClient = HttpClient()
        DispatchQueue.global(qos: .background).async {
            do {
                let jsonAudience = try JSONEncoder().encode(audience)
            
                print("Sending audience payload: \(String(describing: String(data: jsonAudience, encoding: .utf8)))")
            
                httpClient.sendPostRequest(url: getProfileBaseUrl(), data: String(data: jsonAudience, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if(response.isSuccess()) {
                                completion(.success("Profile successfully sent with ContloID: \(String(describing: response.getExternalId()))"))
                            } else {
                                completion(.error(response.getError()))
                            }
                        } catch {
                            print("Error occured : \(error)")
                            completion(.error(ContloError.Error(value)))
                        }
                        
                    case .failure(let error):
                            print("Error occured: \(error)")
                        completion(.error(error))
                                    
                    }
                })
            } catch {
                print("Error occured : \(error)")
            }
        }
        
    }
}
