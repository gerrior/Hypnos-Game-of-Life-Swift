//
//  ConsoleIO.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

enum OutputType {
    case error
    case standard
}

enum OptionType: String {
    case file = "f"
    case generations = "g"
    case help = "h"
    case unknown
    
    init(value: String) {
        switch value {
        case "f": self = .file
        case "g": self = .generations
        case "h": self = .help
        default: self = .unknown
        }
    }
}

var iterations = 10
var path = ""

class ConsoleIO {

    private func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    
    func ingestCommandLine() {
        // number of arguments passed to the program
        let argCount = CommandLine.argc
        var currentArg = 1
        
        while currentArg < argCount {

            // take the first “real” argument (the option argument) from the arguments array
            let argument = CommandLine.arguments[currentArg]
            
            // skip the first character in the argument's string (the hyphen character)
            let (option, value) = getOption(String(argument.suffix(1)))
            
            switch option {
            case .file:
                currentArg = currentArg + 1
                
                if currentArg < argCount {
                    path = CommandLine.arguments[currentArg]
                    writeMessage("Found path \(path)")
                } else {
                    writeMessage("Missing path from option \(value)", to: .error)
                }
            case .generations:
                currentArg = currentArg + 1
                
                if currentArg < argCount {
                    let generations = CommandLine.arguments[currentArg]
                    let temp: Int? = Int(generations)
                    if let temp = temp {
                        iterations = temp
                    } else {
                        writeMessage("generations parameter must be a number.", to: .error)
                        return
                    }
                    writeMessage("Found generations \(generations)")
                } else {
                    writeMessage("Missing generations from option \(value)", to: .error)
                }
            case .help:
                printUsage()
            case .unknown:
                writeMessage("Unknown option \(value)", to: .error)
                printUsage()
            }

            currentArg = currentArg + 1
        }
    }

    func openFile() -> [String] {

        // Includes trailing slash
        let appDirectory = URL(string: CommandLine.arguments[0] as String)!.deletingLastPathComponent()

        // appendingPathComponent fails at 120+ characters.
        let filenameAndPath = appDirectory.absoluteString + path
        print(filenameAndPath)

        // Make sure the file exists
        guard FileManager.default.fileExists(atPath: filenameAndPath) else {
            preconditionFailure("File Not Found: \(filenameAndPath)")
        }
        
        // Read from the file
        do {
            let data = try String(contentsOfFile: filenameAndPath, encoding: String.Encoding.utf8)
            let fileAsArray = data.components(separatedBy: .newlines)
            return fileAsArray
        } catch let error as NSError {
            print("Failed reading from URL: \(filenameAndPath), Error: " + error.localizedDescription)
        }
        return []
    }
    
    func writeFile(outputToWrite: [String]) {
        // Includes trailing slash
        let appDirectory = URL(string: CommandLine.arguments[0] as String)!.deletingLastPathComponent()

        // appendingPathComponent fails at 120+ characters.
        let filenameAndPath = appDirectory.absoluteString + path + "result.txt" // BUGBUG: This can be more elegant
        print(filenameAndPath)
        
        let url = URL(string: filenameAndPath)!.path
        let joinedStrings = outputToWrite.joined(separator: "\n")
        
        // Write the file
        do {
            try joinedStrings.write(toFile: url, atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            print("Failed writing to URL: \(filenameAndPath), Error: " + error.localizedDescription)
        }
    }
    
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            // \u{001B}[;m = reset terminal's text color back to the default
            print("\u{001B}[;m\(message)")
        case .error:
            // \u{001B}[0;31m = control characters that cause Terminal to change the color of the following text strings to red
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func printUsage() {
        
        let executableName = URL(string: CommandLine.arguments[0] as String)!.lastPathComponent
        
        writeMessage("usage:")
        writeMessage("\(executableName) [-g[enerations] int] -f[ile] file (default 10)")
        writeMessage("Default number of generations is 10")
        writeMessage("\(executableName) -h shows this information")
    }
    
}
