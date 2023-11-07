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
        return ContloDefaults.isRemoteLoggingEnabled() && ContloDefaults.getRemoteLoggingLevel() >= level.rawValue
    }
    
    private func logExceptionWithMessage(_ exception: NSException?, _ message: String?) {
        //        guard !(exception is URLError && exception.code.notConnectedToInternet) else {
        //            return
        //        }
        
        //        var event = Event()
        do {
            print("logExceptionWithMessage")
            var sentryMessage = SentryMessage(formatted: message ?? "Some error occured")
            //        var hint = Hint()
            let event = Sentry.Event()
            event.message = sentryMessage
            let scope = Scope()
            
            //        let scope = sentryHub.scope.attach
            //        let fileURL = documentsDirectory.appendingPathComponent("contlo_logs.txt")
            if let documentsDirectory = Utils.getAppDocumentsDirectory() {
                let fileURL = documentsDirectory.appendingPathComponent("contlo_logs.txt")
                //            let attachment = Attachment(path: fileURL.path())
                let attachment = Attachment(path: fileURL.path)
                scope.addAttachment(attachment)
            }
//            event.message?.message = message ?? "Some error occured"
            //        hint
            //        hint.add(Attachment(data: "additionalData".data(using: .utf8), filename: "contlo_logs.txt", contentType: "text/plain"))
            //        hint.add(Attachment(filepath: context.filesDir.absolutePath + "/contlo_logs.txt"))
            //        sentryMessage.message = message
            //        event.message = sentryMessage
            
            if let exception = exception {
                sentryHub.capture(exception: exception, scope: scope)
            } else {
                sentryHub.capture(event: event, scope: scope)
            }
        } catch {
            print("error occured during sentry")
        }
    }

    
}
