//
//  Utils.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 31/10/23.
//

import Foundation
import UserNotifications
import UIKit


class Utils {
    
    static func isNotificationPermission(completion: @escaping (Bool) -> Void) {
        let center = UNUserNotificationCenter.current()
        var permission = false
        center.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                permission = true
                break
            case .denied:
                permission = false
                break;
            case .notDetermined:
                permission = false
                break;
//                    print("Notification permissions are not determined. You should request permission.")
            case .provisional:
                permission = true
                break
//                    print("Notifications are provisionally authorized.")
            case .ephemeral:
                permission = false
                break
            @unknown default:
                permission = false
                break
            }
            completion(permission)
        }
    }
    
    @available(iOS 13.0.0, *)
    static func isNotificationPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
            var permission = false
            
        
        
            await center.getNotificationSettings { settings in
                switch settings.authorizationStatus {
                case .authorized:
                    permission = true
                    break
                case .denied:
                    permission = false
                    break;
                case .notDetermined:
                    permission = false
                    break;
//                    print("Notification permissions are not determined. You should request permission.")
                case .provisional:
                    permission = true
                    break
//                    print("Notifications are provisionally authorized.")
                @unknown default:
                    break
                }
            }
        return permission
    }
    
    static func getAppName() -> String {
        if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return appName
            print("App Name: \(appName)")
        } else if let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return appName
            print("App Name: \(appName)")
        } else {
            return "NOT FOUND"
            print("App Name not found.")
        }

    }
    
    static func getAppVersion() -> String {
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return appVersion
            print("App Version: \(appVersion)")
        } else {
            return "Not Found"
            print("App Version not found.")
        }
    }
    
    static func getPackageName() -> String {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            return bundleIdentifier
            print("Bundle Identifier (similar to package name): \(bundleIdentifier)")
        } else {
            return "Not found"
            print("Bundle Identifier not found.")
        }
    }
    
    static func OS_Version() -> String {
        return UIDevice.current.systemVersion

    }
    
    
    static func getPhoneModel() -> String {
        return UIDevice.current.model
    }
    
    static func getNetworkType() -> String {
        //todo
        return ""
    }
    
    static func getTimezone() -> String {
        return TimeZone.current.identifier
    }
    
    static func getCurrentMillis() -> Int64{
        return  Int64(NSDate().timeIntervalSince1970 * 1000)
    }
    
    static func retrieveUserData() -> [String: String] {
        var data: [String: String] = [
            "app_name": Utils.getAppName(),
            "app_version": Utils.getAppVersion(),
            "source": "Mobile",
            "manufacturer": "Apple",
            "os_type": "iOS",
            "sdk_version": "1.0.0",
            "package_name": Utils.getAppName()
        ]
        return data
    }
    
    static func getAppDocumentsDirectory() -> URL? {
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentsURL
        } catch {
            print("Error getting app's documents directory: \(error)")
            return nil
        }
    }
}

enum ContloError: Error {
    case Error(String)

    var localizedDescription: String {
        switch self {
        case .Error(let message):
            return message
        }
    }

}
