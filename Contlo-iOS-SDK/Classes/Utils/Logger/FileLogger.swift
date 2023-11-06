//
//  FileLogger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation

class FileLogger: LoggerType {
    func log(level: LogLevel, tag: String, message: String) {
        writeLogToFile("\(tag) : \(message)")
    }
    
    func isLoggable(level: LogLevel) -> Bool {
        return level.rawValue >= LogLevel.Debug.rawValue
    }
    func writeLogToFile(_ logText: String) {
//        let fileURL = URL(fileURLWithPath: filePath)
        if let documentsDirectory = getAppDocumentsDirectory() {
            
            do {
                let fileURL = documentsDirectory.appendingPathComponent("contlo_logs.txt")
                // Create a FileManager instance
                let fileManager = FileManager.default

                // Check if the file already exists, and if not, create it
                if !fileManager.fileExists(atPath: fileURL.path) {
                    fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
                }
                
                // Open the file for writing
                if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                    // Seek to the end of the file to append the log
                    fileHandle.seekToEndOfFile()
                    
                    // Convert the log text to data and write it to the file
                    if let data = logText.data(using: .utf8) {
                        fileHandle.write(data)
                    }
                    
                    // Close the file
                    fileHandle.closeFile()
                } else {
                    print("Error opening the file for writing.")
                }
            } catch {
                print("Error writing to the file: \(error)")
            }
        }
        
    }
    
    func getAppDocumentsDirectory() -> URL? {
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            return documentsURL
        } catch {
            print("Error getting app's documents directory: \(error)")
            return nil
        }
    }
    
}
