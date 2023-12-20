//
//  Audience.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation


@objc open class Audience: NSObject, Codable {
    var firstName: String?
    var lastName: String?
    var userCity: String?
    var userCountry: String?
    var userZip: String?
    var userEmail: String?
    var userPhone: String?
    var externalId: String?
    var customProperties: [String: String]?
    var properties: [String: String]?
    var isProfileUpdate: Bool?
    var isMobilePushConsent: Bool?
    var advertisingId: String?
    var apnsToken: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userCity = "city"
        case userCountry = "country"
        case userZip = "zip"
        case userEmail = "email"
        case userPhone = "phone_number"
        case externalId = "external_id"
        case customProperties = "custom_properties"
        case properties = "properties"
        case isProfileUpdate = "is_profile_update"
        case isMobilePushConsent = "mobile_push_consent"
        case advertisingId = "advertising_id"
        case apnsToken = "apns_token"
    }
    
    public init(firstName: String? = nil,
         lastName: String? = nil,
         userCity: String? = nil,
         userCountry: String? = nil,
         userZip: String? = nil,
         userEmail: String? = nil,
         userPhone: String? = nil,
                customProperties: [String: String]? = nil
        ) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.userCity = userCity
        self.userCountry = userCountry
        self.userZip = userZip
        self.userEmail = userEmail
        self.userPhone = userPhone
        self.customProperties = customProperties
    }
    
    init(userEmail: String? = nil, userPhone: String? = nil, externalId: String?, apnsToken: String? = nil, isMobilePushConsent: Bool? = false) {
        self.userEmail = userEmail
        self.userPhone = userPhone
        self.externalId = externalId
        self.apnsToken = apnsToken
        self.isMobilePushConsent = isMobilePushConsent
    }
    
    func setup(externalId: String?, apnsToken: String? = nil, pushConsent: Bool, data: [String: String]) {
        self.externalId = externalId
        self.apnsToken = apnsToken
        self.isMobilePushConsent = pushConsent
        self.userEmail = userEmail?.isEmpty == true ? nil : userEmail
        self.userPhone = userPhone?.isEmpty == true ? nil : userPhone
        self.apnsToken = apnsToken?.isEmpty == true ? nil : apnsToken
        if(properties != nil) {
            properties?.merge(data) { (_, new) in new }
        } else {
            properties = data
        }
    }
}

