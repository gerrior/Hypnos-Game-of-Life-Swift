//
//  GameGrid.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

public enum Patterns {
    // Still Lifes
    case behive

    // Oscillators
    case blinker
    case toad
    case beacon
    case pulsar
    case pentadecathlon

    // Spaceships
    case glider
}

class GameOfLife: NSObject {
    var cells: [Cell] = []

    var generation = 0
    var population: Int {
        cells.filter{ $0.state == .alive }.count
    }

    public init(lifeFile: [String]) {

        // Create grid
        for row in lifeFile {
            if row.starts(with: "#") { continue }
            
            cells.append(Cell(coordinates: row))
        }
        super.init()

//        self.useExamplePattern(pattern: .random)
    }

    func clearGrid() {
        cells.removeAll()
        
        generation = 0
    }

    public func useExamplePattern(pattern: Patterns = .glider) {
        print(pattern)

        clearGrid()

        switch pattern {

        case .behive:
            cells.append(Cell(x: 3, y: 2))
            cells.append(Cell(x: 4, y: 2))

            cells.append(Cell(x: 2, y: 3))
            cells.append(Cell(x: 5, y: 3))

            cells.append(Cell(x: 3, y: 4))
            cells.append(Cell(x: 4, y: 4))

        case .blinker:
            cells.append(Cell(x: 3, y: 2))
            cells.append(Cell(x: 4, y: 2))
            cells.append(Cell(x: 5, y: 2))

        case .toad:
            cells.append(Cell(x: 4, y: 3))
            cells.append(Cell(x: 5, y: 3))
            cells.append(Cell(x: 6, y: 3))

            cells.append(Cell(x: 3, y: 4))
            cells.append(Cell(x: 4, y: 4))
            cells.append(Cell(x: 5, y: 4))

        case .beacon:
            cells.append(Cell(x: 2, y: 2))
            cells.append(Cell(x: 3, y: 2))
            cells.append(Cell(x: 2, y: 3))

            cells.append(Cell(x: 5, y: 4))
            cells.append(Cell(x: 4, y: 5))
            cells.append(Cell(x: 5, y: 5))

        case .pulsar:
            // Row 1
            cells.append(Cell(x: 6, y: 2))
            cells.append(Cell(x: 6, y: 3))
            cells.append(Cell(x: 6, y: 4))
            cells.append(Cell(x: 7, y: 4))

            cells.append(Cell(x: 12, y: 2))
            cells.append(Cell(x: 12, y: 3))
            cells.append(Cell(x: 12, y: 4))
            cells.append(Cell(x: 11, y: 4))

            // Row 2
            cells.append(Cell(x: 2, y: 6))
            cells.append(Cell(x: 3, y: 6))
            cells.append(Cell(x: 4, y: 6))
            cells.append(Cell(x: 4, y: 7))

            cells.append(Cell(x: 7, y: 6))
            cells.append(Cell(x: 8, y: 6))
            cells.append(Cell(x: 8, y: 7))
            cells.append(Cell(x: 6, y: 7))
            cells.append(Cell(x: 6, y: 8))
            cells.append(Cell(x: 7, y: 8))

            cells.append(Cell(x: 10, y: 6))
            cells.append(Cell(x: 11, y: 6))
            cells.append(Cell(x: 10, y: 7))
            cells.append(Cell(x: 12, y: 7))
            cells.append(Cell(x: 11, y: 8))
            cells.append(Cell(x: 12, y: 8))

            cells.append(Cell(x: 14, y: 6))
            cells.append(Cell(x: 15, y: 6))
            cells.append(Cell(x: 16, y: 6))
            cells.append(Cell(x: 14, y: 7))

            // Row 3
            cells.append(Cell(x: 2, y: 12))
            cells.append(Cell(x: 3, y: 12))
            cells.append(Cell(x: 4, y: 12))
            cells.append(Cell(x: 4, y: 11))

            cells.append(Cell(x: 6, y: 10))
            cells.append(Cell(x: 7, y: 10))
            cells.append(Cell(x: 6, y: 11))
            cells.append(Cell(x: 8, y: 11))
            cells.append(Cell(x: 7, y: 12))
            cells.append(Cell(x: 8, y: 12))

            cells.append(Cell(x: 11, y: 10))
            cells.append(Cell(x: 12, y: 10))
            cells.append(Cell(x: 12, y: 11))
            cells.append(Cell(x: 10, y: 11))
            cells.append(Cell(x: 10, y: 12))
            cells.append(Cell(x: 11, y: 12))

            cells.append(Cell(x: 14, y: 11))
            cells.append(Cell(x: 14, y: 12))
            cells.append(Cell(x: 15, y: 12))
            cells.append(Cell(x: 16, y: 12))

            // Row 4
            cells.append(Cell(x: 6, y: 14))
            cells.append(Cell(x: 6, y: 15))
            cells.append(Cell(x: 6, y: 16))
            cells.append(Cell(x: 7, y: 14))

            cells.append(Cell(x: 12, y: 14))
            cells.append(Cell(x: 12, y: 15))
            cells.append(Cell(x: 12, y: 16))
            cells.append(Cell(x: 11, y: 14))

        case .pentadecathlon:
            // Object 1
            cells.append(Cell(x: 5, y: 4))
            cells.append(Cell(x: 6, y: 4))
            cells.append(Cell(x: 7, y: 4))
            cells.append(Cell(x: 6, y: 5))
            cells.append(Cell(x: 6, y: 6))
            cells.append(Cell(x: 5, y: 7))
            cells.append(Cell(x: 6, y: 7))
            cells.append(Cell(x: 7, y: 7))

            // Object 2
            cells.append(Cell(x: 5, y: 9))
            cells.append(Cell(x: 6, y: 9))
            cells.append(Cell(x: 7, y: 9))
            cells.append(Cell(x: 5, y: 10))
            cells.append(Cell(x: 6, y: 10))
            cells.append(Cell(x: 7, y: 10))

            // Object 3
            cells.append(Cell(x: 5, y: 12))
            cells.append(Cell(x: 6, y: 12))
            cells.append(Cell(x: 7, y: 12))
            cells.append(Cell(x: 6, y: 13))
            cells.append(Cell(x: 6, y: 14))
            cells.append(Cell(x: 5, y: 15))
            cells.append(Cell(x: 6, y: 15))
            cells.append(Cell(x: 7, y: 15))

        case .glider:
            cells.append(Cell(x: 3, y: 2))
            cells.append(Cell(x: 4, y: 3))
            cells.append(Cell(x: 4, y: 4))
            cells.append(Cell(x: 3, y: 4))
            cells.append(Cell(x: 2, y: 4))
        }

        generation = 0
    }

    func cellAt(x: Int, y: Int) -> Cell? {
        for cell in cells {
            if cell.x == x && cell.y == y {
                return cell
            }
        }
        return nil
    }

    func performGameTurn() {
        var cellsToKill: [Cell] = []
        var cellsToBirth: [Cell] = []

        for (index, cell) in cells.enumerated() {
            cell.indexDuringTurn = index
            
            var count = 0
            let coordinates = (x: cell.x, y: cell.y)

            // West
            if coordinates.x != 0 {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North West
            if coordinates.x != 0 && coordinates.y != 0 {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y - 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North
            if coordinates.y != 0 {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y - 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North East
            if coordinates.x < Int.max - 1 && coordinates.y != 0 {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y - 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // East
            if coordinates.x < Int.max {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South East
            if coordinates.x < Int.max && coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y + 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South
            if coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y + 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South West
            if coordinates.x != 0 && coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y + 1) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            if cell.state == .alive {
                if count < 2 || count > 3 {
                    cellsToKill.append(cell)
                }
            } else { // cell.state == .dead
                if count == 3 {
                    cellsToBirth.append(cell)
                }
            }
        }

        for cell in cellsToKill {
            // cell.state = .dead
            cells.remove(at: cell.indexDuringTurn)
        }

        for cell in cellsToBirth {
            cells.append(cell)
        }

        generation += 1
    }
}
