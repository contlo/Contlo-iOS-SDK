//
//  ProfileHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

class ProfileHandler {
    let TAG = "ProfileHandler"
    let PROFILE_V2 = "/v2/identify"
    let CONTLO_PROD = "https://api1.contlo.com"
    
    private func getProfileBaseUrl() -> URL {
        return URL(string: CONTLO_PROD + PROFILE_V2)!
    }
    
    private func sendUserData(audience: Audience) -> String {
        
        
        var httpClient = HttpClient()
        
        httpClient.sendPostRequest(url: getProfileBaseUrl(), data: "data", completion: {_ in
            print("completion")
        })
        return "done"
    }
}
