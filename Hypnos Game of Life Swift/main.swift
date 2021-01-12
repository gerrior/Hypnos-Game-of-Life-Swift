//
//  main.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

class GridView: NSObject {

    // MARK: - Properties
    var gameGrid = GameGrid(gridSize: 25)
    private var cellSize: Int = 15

    private var timer: Timer?
    var timeInterval = 0.25
    var timerRunning: Bool {
        timer == nil ? false : true
    }

    // MARK: - Actions

    // MARK: - Outlets

    // MARK: - Initialization
//        let frame = CGRect(x: 0, y: 0, width: cellSize * gridSize, height: cellSize * gridSize)
//        self.init(frame: frame)
//        self.gameGrid = GameGrid(gridSize: gridSize)
//        self.cellSize = cellSize

    // MARK: - Public Interface

    public func cancelTimer() {
        timer?.invalidate()
        timer = nil
    }

    public func cellTapped(at index: Int) {
        gameGrid.cellTapped(at: index)
    }

    public func clearGrid() {
        gameGrid.clearGrid()
    }

    @objc private func performGameTurn() {
        self.gameGrid.performGameTurn()
    }

    public func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(performGameTurn),
                                     userInfo: nil,
                                     repeats: true)
    }

    public func step() {
        gameGrid.performGameTurn()
    }

    public func useExamplePattern(pattern: Patterns) {
        gameGrid.clearGrid()
        gameGrid.useExamplePattern(pattern: pattern)
    }
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

class GofLSwift {

    func getOption(_ option: String) -> (option:OptionType, value: String) {
        return (OptionType(value: option), option)
    }
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        // number of arguments passed to the program
        let argCount = CommandLine.argc
        
        // take the first “real” argument (the option argument) from the arguments array
        let argument = CommandLine.arguments[1]
        
        // skip the first character in the argument's string (the hyphen character)
        let (option, value) = getOption(String(argument.suffix(1)))
        
        switch option {
        case .file:
            consoleIO.writeMessage("\(value) not implemented at this time")
        case .generations:
            consoleIO.writeMessage("\(value) not implemented at this time")
        case .help:
            consoleIO.printUsage()
        case .unknown:
            consoleIO.writeMessage("Unknown option \(value)", to: .error)
            consoleIO.printUsage()
        }
    }
}

let gofl = GofLSwift()

if CommandLine.argc < 2 {
    //TODO: Handle interactive mode
} else {
    gofl.staticMode()
}
