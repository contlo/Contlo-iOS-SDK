//
//  PushHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 03/11/23.
//

import Foundation
class PushHandler {
    static let TAG = "PushHandler"
    
    class func handlePushConsent(consent: Bool, completion: @escaping (String) -> Void) {
        
        let previousConsent = ContloDefaults.getPushConsent()
        if(consent && !previousConsent) {
            sendPushConsent(consent: true, completion: completion)
        } else if(!consent && previousConsent) {
            sendPushConsent(consent: false, completion: completion)
        }
        ContloDefaults.setPushConsent(consent)
    }
    
    class func sendPushConsent(consent: Bool, completion: @escaping (String) -> Void) {
        
        let email = ContloDefaults.getEmail()
        let phone = ContloDefaults.getPhoneNumber()
        let externalId = ContloDefaults.getExternalId()
        let audience = Audience(
            userEmail: email,
            userPhone: phone,
            externalId: externalId
            )
        ProfileHandler.sendUserData(audience: audience, isUpdate: true) {result in
            if(result == "Succesfully sent user data to Contlo") {
                completion("Push consent sent")
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message:"Push consent sent: \(result)")
            } else {
                Logger.sharedInstance.log(level: LogLevel.Error, tag: TAG, message:"Push consent failed to send:  \(result)")
            }
                
        }
    }
}
