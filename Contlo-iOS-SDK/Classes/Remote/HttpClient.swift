//
//  HttpClient.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 30/10/23.
//


import Foundation

class HttpClient {
    
    // Shared URLSession instance for making requests
    private let session = URLSession.shared
    static let TAG = "LifecycleHandler"

    
    // Method to send a GET request with optional headers and return the response as a string
    func sendGetRequest(url: URL, headers: [String: String]? = nil, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                Logger.sharedInstance.log(level: LogLevel.Verbose, tag: HttpClient.TAG, message: "Config fetched: \(responseString)")

                completion(.success(responseString))
            } else {
                completion(.failure(NSError(domain: "HttpClient", code: 1, userInfo: nil)))
            }
        }
        
        
        task.resume()
    }
    
    // Method to send a POST request with optional headers and return the response as a string
    func sendPostRequest(url: URL, data: String, completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if Thread.isMainThread {
            print("Running on the main thread")
        } else {
            print("Running on a background thread")
        }
        
        request.addGlobalHeader()
//        addGlobalHeader(request: request)
//        if let headers = headers {
//            for (key, value) in headers {
//                request.addValue(value, forHTTPHeaderField: key)
//            }
//        }
        
        request.httpBody = data.data(using: .utf8)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                completion(.success(responseString))
            } else {
                completion(.failure(NSError(domain: "HttpClient", code: 1, userInfo: nil)))
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                Logger.sharedInstance.log(level: LogLevel.Verbose, tag: HttpClient.TAG, message: "Post request error: \(response)")
                
                completion(.failure(NSError(domain: "HttpClient", code: 1, userInfo: nil)))

                            return
                    }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                Logger.sharedInstance.log(level: LogLevel.Verbose, tag: HttpClient.TAG, message: "\(url.absoluteString) response is: \(json)")
                    } catch {
                        Logger.sharedInstance.log(level: LogLevel.Error, tag: HttpClient.TAG, message: "Post request error: \(error.localizedDescription)")
                    }
        }
        
        task.resume()
    }
    
    func addGlovalHeader() {
        
    }
    
}

extension URLRequest {
    mutating func addGlobalHeader() {
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        let apiKey = ContloDefaults.getApiKey() ?? "nil"
        self.addValue(apiKey, forHTTPHeaderField: "X-Api-Key")
    }
}
