//
//  ViewController.swift
//  Contlo-iOS-SDK
//
//  Created by AmanContlo on 10/30/2023.
//  Copyright (c) 2023 AmanContlo. All rights reserved.
//

import UIKit
import Contlo_iOS_SDK

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        Contlo.initialize()
//        Contlo.sendUserData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRegister(_ sender: UIButton) {
        print("clicked")
        print(emailField.text)
    }
}

