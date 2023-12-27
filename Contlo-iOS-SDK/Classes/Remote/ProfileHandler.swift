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
    
//    static func sendUserData(email: String? = nil, phoneNumber: String? = nil, firstName: String? = nil, lastName: String? = nil,
//                             userCity: String? = nil, userCountry: String? = nil, userZip: String? = nil, pushConsent: Bool = false,
//                             properties: [String: String] = [:], completion: @escaping (Resource<String>) -> Void) {
//
//        let audience = Audience(
//            firstName: firstName, lastName: "", userEmail: email, customProperties: properties,  properties: Utils.retrieveUserData(), isProfileUpdate: false, isMobilePushConsent: Utils.isNotificationPermission()
//            )
//
//        sendUserData(audience: audience, completion: completion)
//
//    }
//
    static func sendUserData(audience: Audience, isUpdate: Bool, completion: @escaping (String) -> Void) {
        
        let externalId = ContloDefaults.getExternalId()
        let apnsToken = ContloDefaults.getDeviceToken()
        let pushConsent = ContloDefaults.isNotificationEnabled()
        
        
//        let advertisingId = ContloDefaults.getAdvertisingId()
        
        let devicePropery = Utils.retrieveUserData()
//        let finalAudience = Audience(
//            firstName: audience.firstName,
//            lastName: audience.lastName,
//            userCity: audience.userCity,
//            userCountry: audience.userCountry,
//            userZip: audience.userZip,
//            userEmail: audience.userEmail,
//            userPhone: audience.userPhone,
//            externalId: externalId,
//            customProperties: audience.customProperties,
//            properties: devicePropery,
//            isProfileUpdate: isUpdate,
//            isMobilePushConsent: Utils.isNotificationPermission(),
//            advertisingId: advertisingId )
        audience.setup(externalId: externalId, apnsToken: apnsToken, pushConsent: pushConsent, data: devicePropery)
        sendUserToContlo(audience: audience) {result in
            switch result {
            case .success(let value):
                ContloDefaults.setEmail(audience.userEmail ?? nil)
                ContloDefaults.setPhoneNumber(audience.userPhone)
                completion("Succesfully sent user data to Contlo")
                
            case .error(let error):
                completion(error.localizedDescription ?? "Some error occured")
            }
        }
        
    }
    
    static func sendUserToContlo(audience: Audience, completion: @escaping (Resource<String>) -> Void) {
        
        
        var httpClient = HttpClient()
        DispatchQueue.global(qos: .background).async {
            do {
                let jsonAudience = try JSONEncoder().encode(audience)
            
                print("Sending audience payload: \(String(data: jsonAudience, encoding: .utf8))")
            
                httpClient.sendPostRequest(url: getProfileBaseUrl(), data: String(data: jsonAudience, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if(response.isSuccess()) {
    //                            ContloDefaults.setExternalId(externalId: response.getExternalId())
                                completion(.success("Profile successfully sent with ContloID: \(response.getExternalId())"))
                            } else {
                                completion(.error(response.getError()))
                            }
        //                    return Resource<Event>(data: jsonData)
                        } catch {
                            print("Error occured : \(error)")
        //                    return Resource<Event>(throwable: error)
                            completion(.error(ContloError.Error(value)))
                        }
                        
                    case .failure(let error):
                            print("Error occured: \(error)")
                        completion(.error(error))
        //                return Resource<Event>(throwable: error)
                                    
                    }
                })
            } catch {
                print("Error occured : \(error)")
            }
        }
        
    }
}
