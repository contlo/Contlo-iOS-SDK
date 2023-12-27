//
//  ViewController.swift
//  Contlo-iOS-SDK
//
//  Created by AmanContlo on 10/30/2023.
//  Copyright (c) 2023 AmanContlo. All rights reserved.
//

import UIKit
import Contlo_iOS_SDK
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRegister(_ sender: UIButton) {
        print("clicked")
        print(emailField.text)
        let userData = ["userId": "test-user"]
        let finalAudience = Audience(firstName: nameField.text, lastName: "gg",  userEmail: emailField.text, userPhone: phoneNumberField.text, customProperties: userData)
            
        Contlo.sendUserData(audience: finalAudience) {result in
            print("Sending user data: \(result)")
            
            DispatchQueue.main.async {
               
            }
           
        }
        
        let storyboard = UIStoryboard(name: "EventScreen", bundle: nil)
                
                // Instantiate the view controller from the new storyboard
                if let destinationVC = storyboard.instantiateViewController(withIdentifier: "eventStory") as? EventViewController {
                    // Perform the navigation (e.g., push or present)
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
    }
    
    @IBAction func onSkip(_ sender: UIButton) {
        print("skip")
        let storyboard = UIStoryboard(name: "EventScreen", bundle: nil)
                
                // Instantiate the view controller from the new storyboard
                if let destinationVC = storyboard.instantiateViewController(withIdentifier: "eventStory") as? EventViewController {
                    // Perform the navigation (e.g., push or present)
//                    self.navigationController?.pushViewController(destinationVC, animated: true)
                    self.present(destinationVC, animated: true, completion: nil)

                }
        Contlo.sendEvent(eventName: "Skip event")
    }
}

