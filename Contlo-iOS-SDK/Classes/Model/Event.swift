//
//  Event.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

struct Event {
    var eventId: UInt64
    var event: String
    var fcmToken: String?
    var email: String?
    var phoneNumber: String?
    var property: [String: String]
    var pushConsent: Bool
    var deviceEventTime: UInt64
    var profileProperty: [String: String]?
}

//extension Event {
//    init(
//        eventId: UInt64 = generateId(),
//        event: String,
//        fcmToken: String? = nil,
//        email: String? = nil,
//        phoneNumber: String? = nil,
//        property: [String: String] = [:],
//        pushConsent: Bool,
//        deviceEventTime: UInt64,
//        profileProperty: [String: String]? = nil
//    ) {
//        self.eventId = eventId
//        self.event = event
//        self.fcmToken = fcmToken
//        self.email = email
//        self.phoneNumber = phoneNumber
//        self.property = property
//        self.pushConsent = pushConsent
//        self.deviceEventTime = deviceEventTime
//        self.profileProperty = profileProperty
//    }
//    
//    func process() {
//        
//    }
//}


func generateId() -> UInt64 {
    // Generate a random UUID as a string
    let uuidString = UUID().uuidString

    // Convert the UUID string to a numeric format
    let uuidData = Data(uuidString.utf8)
    let uuidUInt64: UInt64 = uuidData.withUnsafeBytes {
        $0.load(as: UInt64.self)
    }

    return uuidUInt64
}

