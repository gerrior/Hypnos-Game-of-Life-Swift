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

let consoleIO = ConsoleIO()

consoleIO.ingestCommandLine()

if path != "" {
    let file = consoleIO.openFile()
    print("Number of lines: \(file.count)")
    
} else {
    consoleIO.writeMessage("File not specifed", to: .error)
    consoleIO.printUsage()
}
