//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Aman Toppo on 16/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

//    @IBOutlet var label: UILabel?
//    @IBOutlet var imageView: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("NotificationContent")
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
//        self.label?.text = notification.request.content.body
//        print("NotificationContent2")
////        guard let attachment = notification.request.content.attachments.first else {
////                    return
////                }
////        Contlo.hand
//        
////        guard let imageURLString = notification.request.content.userInfo["image"] as? String,
////                     let imageURL = URL(string: imageURLString) else {
////                   return
////               }
//        
//        if let urlImageString = notification.request.content.userInfo["image"] as? String {
//                  if let url = URL(string: urlImageString) {
//                      URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
//                          if let _ = error {
//                              return
//                          }
//                          guard let data = data else {
//                              return
//                          }
//                          DispatchQueue.main.async {
////                              self?.imageView.contentMode = .scaleAspectFill
//
//                              self?.imageView.image = UIImage(data: data)
////                              self?.imageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
//                          }
//                      }
//                  }
//              }
       

        
            
    
//
//        let action2 = UNNotificationAction(identifier: "Action2", title: "Button 2", options: [])

        

//        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
//                    if let error = error {
//                        print("Error downloading image: \(error)")
//                        return
//                    }
//
//                    if let data = data, let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self.imageView.image = image
//                        }
//                    }
//                }.resume()
//        guard let attachment = notification.request.content.attachments.first else { return }
//
//                if attachment.urlStartAccessingSecurityScopedResource() {
//                    imageView.image = UIImage(contentsOfFile: attachment.url.path)
//                    attachment.urlStopAccessingSecurityScopedResource()
//                }

                // Handle the deep link URL here
                if let deepLink = notification.request.content.userInfo["primary_url"] as? String {
                    openDeepLink(deepLink)
                }
    }
    
    func openDeepLink(_ deepLink: String) {
            // Handle opening the deep link, e.g., by navigating to a specific screen
            if let url = URL(string: deepLink) {
                extensionContext?.open(url, completionHandler: nil)
            }
        }

}

extension URLSession {
    
    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            completionHandler(data, nil)
        }
        dataTask.resume()
    }
}
