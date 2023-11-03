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
    static let CONTLO_MARKETING_STAGING = "https://staging2.contlo.in"
    
    
    static func getConfigUrl() -> URL {
        return URL(string: (CONTLO_MARKETING_STAGING + CONFIG_ENDPOINT))!
    }
    
    static func checkForConfig(apiKey: String, completion: ((Resource<Config>) -> Void)? = nil) {
        if(ContloDefaults.isNewAppInstall()) {
            fetchConfig(apiKey: apiKey) { value in
                completion?(value)
            }
        } else if(Utils.getCurrentMillis() - ContloDefaults.getLastSyncTime() > ContloDefaults.getConfigTimeframe()) {
            fetchConfig(apiKey: apiKey) { value in
                completion?(value)
            }
        } else {
            completion?(.success(Config(logging_enabled: ContloDefaults.isRemoteLoggingEnabled(), sync_timeframe: ContloDefaults.getConfigTimeframe(), logo_url: ContloDefaults.getLogoUrl(), log_level: ContloDefaults.getRemoteLoggingLevel(), notification_brand_icon: ContloDefaults.showBrandIconInNotification())))
        }
    }
    
    static func fetchConfig(apiKey: String, completion: ((Resource<Config>) -> Void)? = nil) {
        let httpClient = HttpClient()
        
        httpClient.sendGetRequest(url: getConfigUrl(), headers: ["X-Api-Key": apiKey]) { result in
            switch result {
            case .success(let value):
                print("success: \(value.data(using: .utf8))")
                do {
                    let config = try JSONDecoder().decode(Config.self, from: value.data(using: .utf8)!)
                    completion?(.success(config))
                    ContloDefaults.setConfigTimeframe(config.sync_timeframe)
                    ContloDefaults.setLastSyncTime(Utils.getCurrentMillis())
                    ContloDefaults.setRemoteLogging(config.logging_enabled)
                    var logLevel = config.log_level
                    if(config.log_level == 0) {
                        logLevel = 5
                    }
                    ContloDefaults.setRemoteLoggingLevel(logLevel)
                    ContloDefaults.setBrandIconInNotification(config.notification_brand_icon)
                    ContloDefaults.setLogoUrl(config.logo_url ?? "")
//                    completion(.success("Success"))
//                    print("Logging: \(config.logging_enabled)")
                } catch {
                    completion?(.error(ContloError.Error("Error occured: \(error)")))
                    print("Error occured: \(error)")
//                    completion(.failure(NSError("Error"))

                }
                
                
            case .failure(let error):
                completion?(.error(ContloError.Error("Error occured: \(error)")))
                print("error")
            }
        }
    }
}
