//
//  Config.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 02/11/23.
//

import Foundation

struct Config : Decodable {
    var logging_enabled: Bool
    var sync_timeframe: Int
    var logo_url: String?
    var log_level: Int
    var notification_brand_icon: Bool
}
