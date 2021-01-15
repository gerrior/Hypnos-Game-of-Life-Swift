//
//  main.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

let consoleIO = ConsoleIO()

consoleIO.ingestCommandLine()

if consoleIO.path == "" {
    consoleIO.writeMessage("File not specifed", to: .error)
    consoleIO.printUsage()
} else {
    let file = consoleIO.openFile()
    //print("Number of lines: \(file.count)")
    
    let game = GameOfLife(lifeFile: file)
    
    while game.generation < consoleIO.iterations {
        game.performGameTurn()

        if consoleIO.saveAfterEveryIteration {
            let checkpoint = game.exportGrid()
            consoleIO.writeFile(outputToWrite: checkpoint, generations: game.generation)
        }
    }
    
    let result = game.exportGrid()
    consoleIO.writeFile(outputToWrite: result)
}
