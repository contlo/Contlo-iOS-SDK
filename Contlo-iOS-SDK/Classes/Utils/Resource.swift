//
//  Resource.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 02/11/23.
//

import Foundation

enum Resource<T> {
    
    case success(T)
    case error(Error)
    
    var data: T? {
        switch self {
        case .success(let data):
            return data
        case .error:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .error(let error):
            return error
        }
    }
    
    init(data: T) {
        self = .success(data)
    }
    
    init(throwable: Error, data: T? = nil) {
        self = .error(throwable)
    }
}
