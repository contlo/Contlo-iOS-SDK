//
//  File.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

class EventHandler {
    static let TAG = "EventHandler"
    static let EVENTS_V2 = "/v2/track"
    static let CONTLO_PROD = "https://api1.contlo.com"
    static let CONTLO_STAGING = "https://api.contlo.in"
    
    private static func getEventsBaseUrl() -> URL {
        return URL(string: CONTLO_STAGING + EVENTS_V2)!
//        return URL(string: CONTLO_PROD + EVENTS_V2)!
//        return CONTLO_PROD + EVENTS_V2
    }
    
    static func sendAppEvent(eventName: String, completion: @escaping (String) -> Void) {
        let eventProperty: [String: String] = [
            "event_type": "system"
        ]
        let profileProperty: [String: String] = [
            "source": "Mobile"
        ]
        sendEvent(eventName: eventName, eventProperty: eventProperty, profileProperty: profileProperty, completion: completion)
    }
    
    static func sendEvent(eventName: String, completion: @escaping (String) -> Void ) {
        let eventProperty: [String: String] = [
            "event_type": "custom"
        ]
        sendEvent(eventName: eventName, eventProperty: eventProperty, profileProperty: nil, completion: completion)
    }
    
    static func sendEvent(eventName: String, eventProperty: [String:String]?, profileProperty: [String: String]?, completion: ((String) -> Void)? = nil) {
        if(eventName.isEmpty) {
            completion?("Event name is empty")
        }
        let email = ContloDefaults.getEmail()
        let phone = ContloDefaults.getPhoneNumber() ?? nil
        let externalId = ContloDefaults.getExternalId() ?? nil
        let deviceToken = ContloDefaults.getDeviceToken() ?? nil
        let notificationPermission = ContloDefaults.isNotificationEnabled()
        let finalEventName = eventName.replacingOccurrences(of: " ", with: "_")

        var event = Event(event_id: generateId(), 
                          event: finalEventName,
                          email: email,
                          apns_token: deviceToken,
                          phone_number: phone,
                          external_id: externalId,
                          properties: eventProperty,
                          mobile_push_consent: notificationPermission,
                          device_event_time: UInt64(Utils.getCurrentMillis()),
                          profile_properties: profileProperty)
        event.addEventProperty()
        sendEvent(event: event) { result in
            switch result {
            case .success(let value):
                completion?(value)
            case .error(let error):
                completion?("Some error occured: \(error)")
            }
        }
    }
    
    
    static func sendEvent(event: Event, completion: @escaping (Resource<String>) -> Void) {
        if(event.event.isEmpty) {
            completion(.error(ContloError.Error("Event Name is empty")))
        }
        
        var httpClient = HttpClient()
        DispatchQueue.global(qos: .background).async {
            do {
                let jsonEvent = try JSONEncoder().encode(event)
            
    //            print("Sending event payload: \(String(data: jsonEvent, encoding: .utf8))")
                Logger.sharedInstance.log(level: LogLevel.Info, tag: "EventHandler", message: "Sending event payload: \(String(data: jsonEvent, encoding: .utf8))")
            
            
                httpClient.sendPostRequest(url: getEventsBaseUrl(), data: String(data: jsonEvent, encoding: .utf8)!, completion: { result in
                    switch result {
                    case .success(let value):
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: value.data(using: .utf8)!)
                            if(response.isSuccess()) {
                                ContloDefaults.setExternalId(externalId: response.getExternalId())
                                completion(.success("Event successfully sent"))
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
    
    
    private func retrieveEventData() -> [String: String] {
        var data: [String: String] = [
            "app_name": Utils.getAppName(),
            "app_version": Utils.getAppVersion(),
            "time_zone": Utils.getTimezone(),
            "source": "Mobile"
        ]
        return data
    }
    
}
