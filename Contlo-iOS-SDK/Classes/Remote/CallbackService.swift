//
//  File.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 20/11/23.
//

import Foundation
open class CallbackService {
    static let CONTLO_PRODUCTION = "https://callback-service.contlo.com"
    static let CONTLO_STAGING = "https://callback-staging2.contlo.in"
    static let NOTIFICATION_CLICK_ENDPOINT = "/mobilepush_webhooks/mobilepush_click"
    static let TAG = "CallbackService"

    private static func getClickCallbackUrl() -> URL {
//        return URL(string: CONTLO_PRODUCTION + NOTIFICATION_CLICK_ENDPOINT)!
        return URL(string: CONTLO_STAGING + NOTIFICATION_CLICK_ENDPOINT)!

    }
    
    public static func sendNotificationClick(internalId: String) {
        DispatchQueue.global(qos: .background).async {
            var httpClient = HttpClient()
            do {
    //            let jsonEvent = try JSONEncoder().encode(event)
                guard let jsonEvent = try? JSONEncoder().encode(CallbackBody(internalId: internalId)) else { return }

            
    //            print("Sending event payload: \(String(data: jsonEvent, encoding: .utf8))")
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Sending callback with internalId: \(internalId)")
            
                
                httpClient.sendPostRequest(url: getClickCallbackUrl(), data: String(data: jsonEvent, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if( response.isStatusSuccess()) {
                                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Callback successful with internalId: \(internalId)")
    //                            completion(.success("Event successfully sent"))
                            } else {
                                Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
    //                            completion(.error(response.getError()))
                            }
        //                    return Resource<Event>(data: jsonData)
                        } catch {
                            Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            print("Error occured : \(error)")
        //                    return Resource<Event>(throwable: error)
    //                        completion(.error(ContloError.Error(value)))
                        }
                        
                    case .failure(let error):
                        Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed: \(error)")
    //                    completion(.error(error))
        //                return Resource<Event>(throwable: error)
                                    
                    }
                })
            } catch {
                print("Error occured : \(error)")
            }
        }

    }
    
    
    public static func sendNotificationReceive(internalId: String) {
        var httpClient = HttpClient()
        
        DispatchQueue.global(qos: .background).async {
            do {
    //            let jsonEvent = try JSONEncoder().encode(event)
                guard let jsonEvent = try? JSONEncoder().encode(CallbackBody(internalId: internalId)) else { return }

            
    //            print("Sending event payload: \(String(data: jsonEvent, encoding: .utf8))")
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Sending callback with internalId: \(internalId)")
            
            
                httpClient.sendPostRequest(url: getClickCallbackUrl(), data: String(data: jsonEvent, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if(response.isSuccess()) {
                                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Callback successful with internalId: \(internalId)")
    //                            completion(.success("Event successfully sent"))
                            } else {
                                Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
    //                            completion(.error(response.getError()))
                            }
        //                    return Resource<Event>(data: jsonData)
                        } catch {
                            Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            print("Error occured : \(error)")
        //                    return Resource<Event>(throwable: error)
    //                        completion(.error(ContloError.Error(value)))
                        }
                        
                    case .failure(let error):
                        Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed: \(error)")
    //                    completion(.error(error))
        //                return Resource<Event>(throwable: error)
                                    
                    }
                })
            } catch {
                print("Error occured : \(error)")
            }
        }

    }
}

struct CallbackBody: Encodable {
    var internalId: String

    enum CodingKeys: String, CodingKey {
        case internalId = "internal_id"
    }
}
