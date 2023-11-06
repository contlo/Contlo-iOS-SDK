//
//  DefaultLogger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation

class DefaultLogger: LoggerType {
    func log(level: LogLevel, tag: String, message: String) {
        print("\(tag) : \(message)")
    }
    
    func isLoggable(level: LogLevel) -> Bool {
        return true
    }
    
    
}
