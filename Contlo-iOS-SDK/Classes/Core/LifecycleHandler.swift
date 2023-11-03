//
//  LifecycleHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 03/11/23.
//

import Foundation
class LifecycleHandler {
    
    class func addObservers() {
        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(self.appMovedToForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) {
            [self] (notification) in
//            guard let strongSelf = self else {
//                return
//            }
            
            self.appMovedToForeground(notification: notification)
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) {
            [self] (notification) in
//            guard let strongSelf = self else {
//                return
//            }
            
            self.appMovedToBackground(notification: notification)
        }
    }
    
    @objc class func appMovedToForeground(notification: Notification) {
        print("became active")
        EventHandler.sendAppEvent(eventName: "Mobile App Launched") { result in
            print(result)
        }

    }
    
    @objc class func appMovedToBackground(notification: Notification) {
        print("moved to background")
        EventHandler.sendAppEvent(eventName: "Mobile App Backgrounded") {result in
            print(print)
        }
    }
}