//
//  ConfigService.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 02/11/23.
//

import Foundation

class ConfigService {
    static let TAG = "ConfigService"
    static let CONFIG_ENDPOINT = "/v1/fetch_config"
    static let CONTLO_MARKETING = "https://marketing.contlo.com"
    
    
    static func getConfigUrl() -> URL {
        return URL(string: (CONTLO_MARKETING + CONFIG_ENDPOINT))!
    }
    
    static func checkForConfig(apiKey: String) {
        if(ContloDefaults.isNewAppInstall()) {
            fetchConfig(apiKey: apiKey)
        } else if(Utils.getCurrentMillis() - ContloDefaults.getLastSyncTime() > ContloDefaults.getConfigTimeframe()) {
            fetchConfig(apiKey: apiKey)
        }
    }
    
    static func fetchConfig(apiKey: String, completion: @escaping (Result<String, Error>) -> Void) {
        let httpClient = HttpClient()
        
        httpClient.sendGetRequest(url: getConfigUrl(), headers: ["X-Api-Key": apiKey]) { result in
            switch result {
            case .success(let value):
                print("success")
                do {
                    let config = try JSONDecoder().decode(Config.self, from: value.data(using: .utf8)!)
                    ContloDefaults.setConfigTimeframe(config.sync_timeframe)
                    ContloDefaults.setLastSyncTime(Utils.getCurrentMillis())
                    ContloDefaults.setRemoteLogging(config.logging_enabled)
                    let logLevel = config.log_level
                    if(config.log_level == 0) {
                        logLevel = 5
                    }
                    ContloDefaults.setRemoteLoggingLevel(logLevel)
                    ContloDefaults.setBrandIconInNotification(config.notification_brand_icon)
                    ContloDefaults.setLogoUrl(config.logo_url)
//                    completion(.success("Success"))
//                    print("Logging: \(config.logging_enabled)")
                } catch {
                    print("Error occured: \(error)")
//                    completion(.failure(NSError("Error"))

                }
                
                
            case .failure(let error):
                print("error")
            }
        }
    }
}
