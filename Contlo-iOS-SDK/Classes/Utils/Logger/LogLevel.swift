//
//  LogLevel.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation

public enum LogTag: String {
    case Observable
    case Model
    case ViewModel
    case View
}

public enum LogLevel: Int {
    case NoLog = 0
    case Verbose = 1
    case Debug = 2
    case Info = 3
    case Warning = 4
    case Error = 5
}

//public protocol Loggable {
//    var defaultLoggingTag: String { get }
//
//    func log(level: LogLevel, _ message: @autoclosure () -> Any, _ path: String, _ function: String, line: Int)
//    func log(level: LogLevel, tag: String,  message: @autoclosure () -> Any, _ path: String, _ function: String, line: Int)
//}
