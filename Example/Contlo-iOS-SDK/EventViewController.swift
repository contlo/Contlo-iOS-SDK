//
//  EventViewController.swift
//  Contlo-iOS-SDK_Example
//
//  Created by Aman Toppo on 07/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import Contlo_iOS_SDK

class EventViewController: UIViewController {
    
    @IBOutlet weak var orderPhone: UIButton!
    @IBOutlet weak var orderLaptop: UIButton!
    @IBOutlet weak var orderMac: UIButton!
    
    
    @IBAction func onOrderPhone(_ sender: UIButton) {
        print("skip")
        Contlo.sendEvent(eventName: "Order Phone")
    }
    
    @IBAction func onOrderLaptop(_ sender: UIButton) {
        print("skip")
        Contlo.sendEvent(eventName: "Order Laptop")
    }
    
    @IBAction func onOrderMac(_ sender: UIButton) {
        print("skip")
        Contlo.sendEvent(eventName: "Order Laptop")
    }
}
