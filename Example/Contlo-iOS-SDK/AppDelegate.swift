//
//  AppDelegate.swift
//  Contlo-iOS-SDK
//
//  Created by AmanContlo on 10/30/2023.
//  Copyright (c) 2023 AmanContlo. All rights reserved.
//

import UIKit
import UserNotifications
import Contlo_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Contlo.initialize(apiKey: "1d46528dc635992b494ffb8961f653be")
        registerForPushNotifications()
        notification()
        // Override point for customization after application launch.
        return true
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Did register for remote notification")
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        Contlo.sendDeviceToken(token: token)
        print("Device Token real : \(deviceToken)")
        
        // Register the device token with Pinpoint as the endpoint for this user
//        pinpoint!.notificationManager.interceptDidRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("APNs registration failed: \(error)")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options:
                                                                    [.alert, .badge, .sound]){(granted, error) in
            print("Permission Granted: \(granted)")
            
            // 1. Check if permission granted
            guard granted else { return }
            Contlo.setNotificationPermission(granted: true)
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let notification = response.notification
        let userInfo = notification.request.content.userInfo
        let actionIdentifier = response.actionIdentifier

        // Check for a specific custom key in the userInfo dictionary
        if let customValue = userInfo["internal_id"] as? String {
            print("Received notification with custom value: \(customValue)")
            CallbackService.sendNotificationClick(internalId: customValue)
        }

        // Handle the tapped notification and perform actions based on the identifier
        if actionIdentifier == UNNotificationDefaultActionIdentifier {
            // The default action (tapping the notification body)
            print("Tapped on the notification body")
        } else {
            // Handle custom actions if applicable
            print("Tapped on a custom action with identifier: \(actionIdentifier)")
        }

        // Call the completion handler when done processing the response
        completionHandler()
    }
    
    func notification() {
//        let notification = UNUserNotificationCenter.current()
//        let button1Action = UNNotificationAction(identifier: "Shop now", title: "Button 1", options: [])
//        let button2Action = UNNotificationAction(identifier: "Cancel", title: "Button 2", options: [])
//
//        let category = UNNotificationCategory(identifier: "Contlo", actions: [button1Action, button2Action], intentIdentifiers: [], options: [])
//
//        UNUserNotificationCenter.current().setNotificationCategories([category])
    }


}

