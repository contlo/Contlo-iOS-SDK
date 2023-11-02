//
//  File.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

class EventHandler {
    let TAG = "EventHandler"
    let EVENTS_V2 = "/v2/track"
    let CONTLO_PROD = "https://api1.contlo.com"
    
    private func getEventsBaseUrl() -> URL {
        return URL(string: CONTLO_PROD + EVENTS_V2)!
//        return CONTLO_PROD + EVENTS_V2
    }
    
    func sendEvent(eventName: String) -> String {
        if(eventName.isEmpty) {
            return "Event name cannot be empty"
        }
        
        var httpClient = HttpClient()
        
        httpClient.sendPostRequest(url: getEventsBaseUrl(), data: eventName, completion: {_ in
            print("completion")
        })
        return "done"
    }
    
    
    private func retrieveEventData() -> [String: String] {
        var data: [String: String] = [
            "app_name": Utils.getAppName(),
            "app_version": Utils.getAppVersion(),
            "time_zone": Utils.getTimezone()
        ]
        return data
    }
    
}
