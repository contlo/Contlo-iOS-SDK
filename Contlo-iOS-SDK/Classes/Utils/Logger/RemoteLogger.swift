//
//  RemoteLogger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation
import Sentry
class RemoteLogger: LoggerType {
    
    private var sentryHub: SentryHub
    
    
    init() {
        let option = Options()
        option.dsn = "https://d0d7c89d3eae17bea4b2e9ea056175d4@o4505912508022784.ingest.sentry.io/4505912509202432"
        let sentryClient = SentryClient(options: option)
        sentryHub = SentryHub(client: sentryClient, andScope: nil)
        let user = User()
        user.email = ContloDefaults.getEmail()
        var map = [String: String]()

        if let phoneNumber = ContloDefaults.getPhoneNumber() {
            map["phone_number"] = phoneNumber
        }
        user.data = map
    }
    
    func log(level: LogLevel, tag: String, message: String?, exception: NSException?) {
        logExceptionWithMessage(exception, message)
    }
    
    func isLoggable(level: LogLevel) -> Bool {
        return ContloDefaults.isRemoteLoggingEnabled() && ContloDefaults.getRemoteLoggingLevel() <= level.rawValue
    }
    
    private func logExceptionWithMessage(_ exception: NSException?, _ message: String?) {
        do {
            print("logExceptionWithMessage")
            let sentryMessage = SentryMessage(formatted: message ?? "Some error occured")
            let event = Sentry.Event()
            event.message = sentryMessage
            let scope = Scope()
        
            if let documentsDirectory = Utils.getAppDocumentsDirectory() {
                let fileURL = documentsDirectory.appendingPathComponent("contlo_logs.txt")
                let attachment = Attachment(path: fileURL.path)
                scope.addAttachment(attachment)
            }
            
            if let exception = exception {
                sentryHub.capture(exception: exception, scope: scope)
            } else {
                sentryHub.capture(event: event, scope: scope)
            }
        }
    }

    
}
