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
    var cells = [String:Cell]()
    var cellEggs = [String:Cell]()

    var cellsToKill = [String]()
    var cellsToBirth = [String]()

    var generation = 0
    var population: Int {
        cells.filter{ $0.value.state == .alive }.count
    }

    public init(lifeFile: [String]) {

        // Create grid
        for row in lifeFile {
            if row.starts(with: "#") { continue }
            
            let trimmedRow = row.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedRow.count < 3 { continue }
            
            cells[trimmedRow] = Cell(coordinates: trimmedRow)
        }
        super.init()

//BUGBUG        self.useExamplePattern(pattern: .random)
    }

    func clearGrid() {
        cells.removeAll()
        
        generation = 0
    }

    func exportGrid() -> [String] {
        var results = ["#Life 1.06"]
        
        let sortedDictionary = cells.sorted(by: { $0.0 < $1.0 } )
        
        for (key, _) in sortedDictionary {
            results.append(key)
        }
        
        return results
    }
    
    public func useExamplePattern(pattern: Patterns = .glider) {
        print(pattern)

        clearGrid()

        var cell: Cell
        
        switch pattern {

        case .behive:
            cell = Cell(x: 3, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 2); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 2, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 3); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 3, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 4); cells["\(cell.x) \(cell.y)"] = cell

        case .blinker:
            cell = Cell(x: 3, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 2); cells["\(cell.x) \(cell.y)"] = cell

        case .toad:
            cell = Cell(x: 4, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 3); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 3, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 4); cells["\(cell.x) \(cell.y)"] = cell

        case .beacon:
            cell = Cell(x: 2, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 3, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 2, y: 3); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 5, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 5); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 5); cells["\(cell.x) \(cell.y)"] = cell

        case .pulsar:
            // Row 1
            cell = Cell(x: 6, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 4); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 12, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 11, y: 4); cells["\(cell.x) \(cell.y)"] = cell

            // Row 2
            cell = Cell(x: 2, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 3, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 7); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 7, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 8, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 8, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 8); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 8); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 10, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 11, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 10, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 11, y: 8); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 8); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 14, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 15, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 16, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 14, y: 7); cells["\(cell.x) \(cell.y)"] = cell

            // Row 3
            cell = Cell(x: 2, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 3, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 11); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 6, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 11); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 8, y: 11); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 8, y: 12); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 11, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 11); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 10, y: 11); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 10, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 11, y: 12); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 14, y: 11); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 14, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 15, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 16, y: 12); cells["\(cell.x) \(cell.y)"] = cell

            // Row 4
            cell = Cell(x: 6, y: 14); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 15); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 16); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 14); cells["\(cell.x) \(cell.y)"] = cell

            cell = Cell(x: 12, y: 14); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 15); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 12, y: 16); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 11, y: 14); cells["\(cell.x) \(cell.y)"] = cell

        case .pentadecathlon:
            // Object 1
            cell = Cell(x: 5, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 5); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 6); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 7); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 7); cells["\(cell.x) \(cell.y)"] = cell

            // Object 2
            cell = Cell(x: 5, y: 9); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 9); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 9); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 10); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 10); cells["\(cell.x) \(cell.y)"] = cell

            // Object 3
            cell = Cell(x: 5, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 12); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 13); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 14); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 5, y: 15); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 6, y: 15); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 7, y: 15); cells["\(cell.x) \(cell.y)"] = cell

        case .glider:
            cell = Cell(x: 3, y: 2); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 3); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 4, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 3, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            cell = Cell(x: 2, y: 4); cells["\(cell.x) \(cell.y)"] = cell
            
        }

        generation = 0
    }

    func cellAt(x: Int, y: Int, createIfNotPresent: Bool = true) -> Cell? {
        let key = "\(x) \(y)"

        // Is it in the current list of live cells?
        if cells[key] != nil {
            return cells[key]
        }
        
        // Is it in the current list of dead adjacent cells?
        if cellEggs[key] != nil {
            return cellEggs[key]
        }

        let newCell = Cell(x: x, y: y, state: .dead)
        
        if createIfNotPresent {
            cellEggs[key] = newCell
        } // else we'll just return an object to satisfy the caller logic
        
        return newCell
    }

    func lookAround(aliveCells: Bool = true) {
        var cellsToSearch = cellEggs
        
        if aliveCells {
            cellsToSearch = cells
        }
        
        for (key, cellToCheck) in cellsToSearch {
            var count = 0
            let coordinates = (x: cellToCheck.x, y: cellToCheck.y)

            // West
            if coordinates.x != Int.min {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North West
            if coordinates.x != Int.min && coordinates.y != Int.min {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North
            if coordinates.y != Int.min {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North East
            if coordinates.x < Int.max && coordinates.y != Int.min {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // East
            if coordinates.x < Int.max {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South East
            if coordinates.x < Int.max && coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South
            if coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South West
            if coordinates.x != Int.min && coordinates.y < Int.max {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // One pass cellsToKill is called. The other pass, cellsToBirth
            if (count < 2 || count > 3) && cellToCheck.state == .alive {
                cellsToKill.append(key)
            } else {
                if count == 3 && cellToCheck.state == .dead {
                    cellsToBirth.append(key)
                }
            }
        }
    }
    
    func performGameTurn() {
        cellsToKill.removeAll()
        cellsToBirth.removeAll()
        cellEggs.removeAll()

        lookAround(aliveCells: true)
        lookAround(aliveCells: false)
        
        // TODO look at all the cell Eggs to see if they need to be born?

        // Remove dead cells
        for dead in cellsToKill {
            cells[dead] = nil
        }

        // Add cells that were born this turn
        for born in cellsToBirth {
            let cell = cellEggs[born]!
            cell.state = .alive
            cells[born] = cell
        }

        generation += 1
    }
}
