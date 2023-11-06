//
//  PushHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 03/11/23.
//

import Foundation
class PushHandler {
    static let TAG = "LifecycleHandler"
    
    class func handlePushConsent(consent: Bool) {
        
        let previousConsent = ContloDefaults.getPushConsent()
        if(consent && !previousConsent) {
            sendPushConsent(consent: true)
        } else if(!consent && previousConsent) {
            sendPushConsent(consent: false)
        }
        ContloDefaults.setPushConsent(consent)
    }
    
    class func sendPushConsent(consent: Bool) {
        
        let email = ContloDefaults.getEmail()
        let phone = ContloDefaults.getPhoneNumber()
        let externalId = ContloDefaults.getExternalId()
        let audience = Audience(
            userEmail: email,
            userPhone: phone,
            externalId: externalId
            )
        ProfileHandler.sendUserData(audience: audience, isUpdate: true) {result in
            print("Push consent sent: \(result)")
        }
    }
}
