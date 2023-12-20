//
//  LifecycleHandler.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 03/11/23.
//

import Foundation
import BackgroundTasks

class LifecycleHandler {
    static let TAG = "LifecycleHandler"
    
    class func addObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(deviceTokenDidRegister(_:)), name: Notification.Name("DidRegisterForRemoteNotifications"), object: nil)

        notificationCenter.addObserver(self, selector: #selector(handleNotificationResponse(_:)), name: Notification.Name("userNotificationCenterDidReceiveResponse"), object: nil)

        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidBecomeActive, object: nil, queue: nil) {
            [self] (notification) in
            
            self.appMovedToForeground(notification: notification)
        }
        
        notificationCenter.addObserver(forName: NSNotification.Name.UIApplicationDidEnterBackground, object: nil, queue: nil) {
            [self] (notification) in
            
            self.appMovedToBackground(notification: notification)
        }
    }
    
    @objc func handleNotificationResponse(_ notification: Notification) {
        print("Notification received")

        if let response = notification.userInfo?["response"] as? UNNotificationResponse {
            // Handle the notification response
            
            print("Notification response received: \(response)")
            
            if let internalId = response.notification.request.content.userInfo["internal_id"] as? String {
                
                CallbackService.sendNotificationClick(internalId: internalId)
            }
            
            // Check the action identifier
            if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                // The user tapped on the notification itself (not a specific action)
            } else {
                // The user tapped on a specific action
                print("Action identifier: \(response.actionIdentifier)")
                if response.actionIdentifier == "Button1Action" {
                       // Handle Button 1 action
                       if let deepLink = response.notification.request.content.userInfo["primaryUrl"] as? String {
                           print(deepLink)
//                           openDeepLink(deepLink)
                       }
                   } else if response.actionIdentifier == "Button2Action" {
                       // Handle Button 2 action
                       if let deepLink = response.notification.request.content.userInfo["primaryUrl"] as? String {
                           print(deepLink)
//                           openDeepLink(deepLink)
                       }
                   }
            }
        }
    }
    
    @objc func deviceTokenDidRegister(_ notification: Notification) {
           if let deviceToken = notification.userInfo?["deviceToken"] as? Data {
               // Handle the device token
               print("Device token registered: \(deviceToken)")
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
        
        if #available(iOSApplicationExtension 13.0, *) {
            let processinfo = ProcessInfo()
               processinfo.performExpiringActivity(withReason: "backgroundEvent") { (expired) in
                   if (!expired) {
                       // Run task synchronously.
                       self.sendBackgroundedEvent()
                   }
                   else {
                       // Cancel task.
                      // self.cancelLongTask()
                   }
               }
        } else {
            self.sendBackgroundedEvent()
        }
    }
    
    class func sendBackgroundedEvent() {
        // Execute API request
        EventHandler.sendAppEvent(eventName: "Mobile App Backgrounded") {result in
            print(print)
        }
    }
    
    
}
