//
//  main.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

let consoleIO = ConsoleIO()

consoleIO.ingestCommandLine()

if path != "" {
    let file = consoleIO.openFile()
    print("Number of lines: \(file.count)")
    
    let game = GameOfLife(lifeFile: file)
    
    
} else {
    consoleIO.writeMessage("File not specifed", to: .error)
    consoleIO.printUsage()
}
