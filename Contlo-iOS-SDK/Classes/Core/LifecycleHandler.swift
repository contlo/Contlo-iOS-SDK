//
//  LifecycleHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 03/11/23.
//

import Foundation
class LifecycleHandler {
    static let TAG = "LifecycleHandler"
    
    class func addObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) {
            [self] (notification) in
            
            self.appMovedToForeground(notification: notification)
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) {
            [self] (notification) in
            
            self.appMovedToBackground(notification: notification)
        }
    }
    
    @objc class func appMovedToForeground(notification: Notification) {
        Logger.sharedInstance.log(level: LogLevel.Verbose, tag: self.TAG, message: "App Moved to foreground")
        EventHandler.sendAppEvent(eventName: "Mobile App Launched") { result in
            print(result)
        }
    }
    
    @objc class func appMovedToBackground(notification: Notification) {
        Logger.sharedInstance.log(level: LogLevel.Verbose, tag: self.TAG, message: "App Moved to background")
        EventHandler.sendAppEvent(eventName: "Mobile App Backgrounded") {result in
            print(print)
        }
    }
}
