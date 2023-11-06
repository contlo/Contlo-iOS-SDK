//
//  RemoteLogger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation
import Sentry
class RemoteLogger: LoggerType {
    
//    val sentryHub: SentryHub
    
    init() {
        let option = Options()
        option.dsn = "ada"
        let sentryClient = SentryClient(options: option)
        let sentryHub = SentryHub(client: sentryClient, andScope: nil)
        let user = User()
        user.email = ContloDefaults.getEmail()
//        user.data =
    }
    func log(level: LogLevel, tag: String, message: String) {
        
    }
    
    func isLoggable(level: LogLevel) -> Bool {
        return ContloDefaults.isRemoteLoggingEnabled() && ContloDefaults.getRemoteLoggingLevel() >= level.rawValue
    }
    
    func sendException() {
        
    }
    
}
