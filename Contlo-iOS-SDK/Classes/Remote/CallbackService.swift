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
    static let NOTIFICATION_RECEIVE_ENDPOINT = "/mobilepush_webhooks/mobilepush_receive"
    static let TAG = "CallbackService"
    
    private static func getClickCallbackUrl() -> URL {
        //        return URL(string: CONTLO_PRODUCTION + NOTIFICATION_CLICK_ENDPOINT)!
        return URL(string: CONTLO_PRODUCTION + NOTIFICATION_CLICK_ENDPOINT)!
        
    }
    
    private static func getReceiveCallbackUrl() -> URL {
        return URL(string: CONTLO_PRODUCTION + NOTIFICATION_RECEIVE_ENDPOINT)!
    }
    
    public static func sendNotificationClick(internalId: String) {
        DispatchQueue.global(qos: .background).async {
            let httpClient = HttpClient()
            do {
                guard let jsonEvent = try? JSONEncoder().encode(CallbackBody(internalId: internalId)) else { return }
                
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Sending callback with internalId: \(internalId)")
                
                
                httpClient.sendPostRequest(url: getClickCallbackUrl(), data: String(data: jsonEvent, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if( response.isStatusSuccess()) {
                                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Callback successful with internalId: \(internalId)")
                            } else {
                                Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            }
                        } catch {
                            Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            print("Error occured : \(error)")
                        }
                        
                    case .failure(let error):
                        Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed: \(error)")
                    }
                })
            }
        }
        
    }
    
    
    public static func sendNotificationReceive(internalId: String) {
        if #available(iOSApplicationExtension 13.0, *) {
            let processinfo = ProcessInfo()
            processinfo.performExpiringActivity(withReason: "receiveCallback") { (expired) in
                if (!expired) {
                    // Run task synchronously.
                    self.sendReceiveCall(internalId: internalId)
                }
                else {
                    // Cancel task.
                    // self.cancelLongTask()
                }
            }
        } else {
            self.sendReceiveCall(internalId: internalId)
        }
    }
    
    public static func sendReceiveCall(internalId: String) {
        DispatchQueue.global(qos: .background).async {
            do {
                let httpClient = HttpClient()
                guard let jsonEvent = try? JSONEncoder().encode(CallbackBody(internalId: internalId)) else { return }
                
                
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Sending callback with internalId: \(internalId)")
                
                
                httpClient.sendPostRequest(url: getReceiveCallbackUrl(), data: String(data: jsonEvent, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if(response.isSuccess()) {
                                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Callback successful with internalId: \(internalId)")
                            } else {
                                Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            }
                        } catch {
                            Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed with internalId: \(internalId)")
                            print("Error occured : \(error)")
                        }
                        
                    case .failure(let error):
                        Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message: "Sending callback failed: \(error)")
                        
                    }
                })
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
