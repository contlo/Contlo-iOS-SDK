//
//  Logger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation

protocol LoggerType {
    func log(level: LogLevel, tag: String, message: String?, exception: NSException?)
    func isLoggable(level: LogLevel) -> Bool
}

final class Logger {
    internal var activeLogger = [LoggerType]()
    internal var disabledSymbols = Set<String>()
    private(set) static var sharedInstance = Logger()

    /// Overrides shared instance, useful for testing
    static func setSharedInstance(logger: Logger) {
        sharedInstance = logger
    }

    func addAdapter(logger: any LoggerType) {
//        assert(activeLogger == nil, "Changing logger is disallowed to maintain consistency")
        activeLogger.append(logger)
    }
    
    func removeAdapters() {
        activeLogger.removeAll()
    }
    func log(level: LogLevel, tag: String, message: String) {
       log(level: level, tag: tag, message: message, exception: nil)
    }
    func log(level: LogLevel, tag: String, exception: NSException) {
        log(level: level, tag: tag, message: nil, exception: exception)
    }
    
    private func log(level: LogLevel, tag: String, message: String?, exception: NSException?) {
//        guard logAllowed(tag: tag, className: className) else { return }
        for logger in activeLogger {
            if(logger.isLoggable(level: level)) {
                logger.log(level: level, tag: tag, message: message, exception: exception)
            }
        }
    }
}
