//
//  GameGrid.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

class GameOfLife: NSObject {
    var cells = [String:Cell]()
    var potentialCells = [String:Cell]()

    var cellsToKill = [String]()
    var cellsToBirth = [String]()

    var generation = 0
    var population: Int {
        cells.filter{ $0.value.state == .alive }.count
    }

    public init(lifeFile: [String]) {

        // Create sparse grid
        for row in lifeFile {
            if row.starts(with: "#") { continue }
            
            let trimmedRow = row.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedRow.count < 3 { continue }
            
            cells[trimmedRow] = Cell(coordinates: trimmedRow)
        }
        super.init()
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

    func cellAt(x: Int, y: Int, createIfNotPresent: Bool = true) -> Cell? {
        let key = "\(x) \(y)"

        // Is key in the current list of live cells?
        if cells[key] != nil {
            return cells[key]
        }
        
        // Is key in the current list of potential cells?
        if potentialCells[key] != nil {
            return potentialCells[key]
        }

        // Not found it. Create a cell so caller logic can process it
        let newCell = Cell(x: x, y: y, state: .dead)
        
        if createIfNotPresent {
            // This is a cell adjacent to a live cell. It could spring to life so we need to check it later
            potentialCells[key] = newCell
        } // else we're checking a dead adjacent cell; we don't want to check further; so don't add to potentialCells
        // we'll just return an object to satisfy the caller logic
        
        return newCell
    }

    func lookAround(aliveCells: Bool = true) {
        var cellsToSearch = potentialCells
        
        if aliveCells {
            cellsToSearch = cells
        }
        
        for (key, cellToCheck) in cellsToSearch {
            var count = 0
            let coordinates = (x: cellToCheck.x, y: cellToCheck.y)

            // West
            if coordinates.x != Int.min + 1 {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North West
            if coordinates.x != Int.min + 1 && coordinates.y != Int.min + 1 {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North
            if coordinates.y != Int.min + 1 {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // North East
            if coordinates.x < Int.max - 1 && coordinates.y != Int.min + 1 {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y + 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // East
            if coordinates.x < Int.max - 1 {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South East
            if coordinates.x < Int.max - 1 && coordinates.y < Int.max - 1 {
                if let cell = cellAt(x: coordinates.x + 1, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South
            if coordinates.y < Int.max - 1 {
                if let cell = cellAt(x: coordinates.x, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // South West
            if coordinates.x != Int.min + 1 && coordinates.y < Int.max - 1 {
                if let cell = cellAt(x: coordinates.x - 1, y: coordinates.y - 1, createIfNotPresent: aliveCells) {
                    if cell.state == .alive {
                        count = count + 1
                    }
                }
            }

            // One pass looks at cells (alive). The other pass looks as potentialCells (dead)
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
        cellsToKill.removeAll() // Array of keys
        cellsToBirth.removeAll() // Array of keys
        potentialCells.removeAll() // Dictionary of key, cell

        // Look at all live cells, record if they need to die
        lookAround(aliveCells: true)
        // The pior call will add cells to potentialCells
        // These are the adjacent cells to live cells
        // We now need to check if any of these cells will spring to life
        lookAround(aliveCells: false)
        
        // Remove dead cells
        for dead in cellsToKill {
            // Use the dead key to set the dictionary value to nil
            cells[dead] = nil
        }

        // Add cells that were born this turn
        for born in cellsToBirth {
            // Use the born key to access the cell in the dictionary
            let cell = potentialCells[born]!
            // Set its new state to alive
            cell.state = .alive
            // Add the new cell to the list of alive cells
            cells[born] = cell
        }

        generation += 1
    }
}
