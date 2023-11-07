//
//  FileLogger.swift
//  Contlo-iOS-SDK
//
//  Created by Aman Toppo on 06/11/23.
//

import Foundation

class FileLogger: LoggerType {
    var LOGS_COUNT_THRESHOLD = 15
    
    func log(level: LogLevel, tag: String, message: String?, exception: NSException?) {
        if let exception = exception {
            print("wrote to file exc")

            writeLogToFile("\(tag) caught exception: \(exception.name) Stack trace: \(exception.callStackSymbols)")
        } else {
            print("wrote to file")
            writeLogToFile("\(tag) : \(message ?? "Some error occured")")
        }
    }
    
    func isLoggable(level: LogLevel) -> Bool {
        return level.rawValue >= LogLevel.Debug.rawValue
    }
    func writeLogToFile(_ logText: String) {
        let logCount = ContloDefaults.getLoggingCount()
        if logCount < LOGS_COUNT_THRESHOLD {
            ContloDefaults.setLogsCount(logCount + 1)
        } else {
            deleteLogFile()
            ContloDefaults.setLogsCount(0)
        }

        if let documentsDirectory = Utils.getAppDocumentsDirectory() {
            
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
                    var text = logText + "\n"
                    // Convert the log text to data and write it to the file
                    if let data = text.data(using: .utf8) {
                        fileHandle.write(data)
                    }
                    print("wrote to file and closed")
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
    
    func deleteLogFile() {
        
        if let documentsDirectory = Utils.getAppDocumentsDirectory() {
            
            do {
                let fileURL = documentsDirectory.appendingPathComponent("contlo_logs.txt")
                // Create a FileManager instance
                let fileManager = FileManager.default
                
                // Check if the file already exists, and if not, create it
                if fileManager.fileExists(atPath: fileURL.path) {
                    try fileManager.removeItem(atPath: fileURL.path)
                }
            } catch {
                print("Error deleting the file: \(error)")
            }
            
        }
    }
    

    
}
