//
//  Response.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 02/11/23.
//

import Foundation
struct Response: Decodable {
    var success: Bool?
    var error: String?
    var external_id: String?
    
}

extension Response {
    func isSuccess() -> Bool {
        return self.success ?? false
    }
    
    func getError() -> Error {
        if(success != nil && success == false) {
            return ContloError.Error(error ?? "Some error occured")
        }
        return ContloError.Error("Some error occured")
    }
    
    func getExternalId() -> String? {
        return external_id
    }
}

