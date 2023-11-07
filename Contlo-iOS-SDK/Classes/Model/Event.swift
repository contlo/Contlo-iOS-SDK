//
//  Event.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation

struct Event : Codable {
    var event_id: UInt64
    var event: String
    var email: String?
    var phone_number: String?
    var external_id: String?
    var properties: [String: String]?
    var mobile_push_consent: Bool
    var device_event_time: UInt64
    var profile_properties: [String: String]?
}

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

extension Event {
    mutating func addEventProperty() {
        var data: [String: String] = [
            "app_name": Utils.getAppName(),
            "app_version": Utils.getAppVersion(),
//            "time_zone": Utils.getTimezone(),
//            "source": "Mobile"
        ]
        properties?.merge(data) { (_, new) in new }
    }
}
