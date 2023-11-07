//
//  ContloTest.swift
//  Contlo-iOS-SDK_Tests
//
//  Created by Aman Toppo on 07/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Nimble
import Quick
import Contlo_iOS_SDK


class ContloTest: QuickSpec {
    override func spec() {
        describe("All method which are exposed to users") {
            
            it("try to initialize") {
                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    
                    Contlo.initialize(apiKey: "d9fa1a810ce66312beab9f86eaa3480c") { value in
                        expect(value) == "Contlo Initialized"
                        done()
                    }
                }
            }
            
            it("try to send User") {
                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    let audience = Audience(firstName: "Contlo", lastName: "Test")
                    Contlo.sendUserData(audience: audience) {value in
                        expect(value) == "Succesfully sent user data to Contlo"
                        done()
                    }
                }
                
            }
            
            it("send Empty Event Name") {
                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    //                    let audience = Audience(firstName: "Contlo", lastName: "Test")
                    Contlo.sendEvent(eventName: "") {value in
                        expect(value) == "Event name cannot be empty"
                        done()
                    }
                    
                }
            }
            
            it("send correct Event") {
                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    //                    let audience = Audience(firstName: "Contlo", lastName: "Test")
                    Contlo.sendEvent(eventName: "Order phone") {value in
                        expect(value) == "Event successfully sent"
                        done()
                    }
                    
                }
            }
            
            it("try to send Push consent") {
                waitUntil(timeout: DispatchTimeInterval.seconds(5)) { done in
                    //                    let audience = Audience(firstName: "Contlo", lastName: "Test")
                    Contlo.sendPushConsent(consent: true) {value in
                        expect(value) == "Push consent sent"
                        done()
                    }
                    
                }
                
            }
            
           
        }
        
    }
}
