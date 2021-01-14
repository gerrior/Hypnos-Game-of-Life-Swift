//
//  Cell.swift
//  Hypnos Game of Life Swift
//
//  Created by Mark Gerrior on 1/11/21.
//

import Foundation

public enum State {
    case dead
    case alive
}

public class Cell: NSObject {
    public let x: Int
    public let y: Int
    public var state: State

    public init(x: Int, y: Int, state: State = .alive) {
        self.x = x
        self.y = y
        self.state = state
    }

    public init(coordinates coordinatesString: String, state: State = .alive) {
        let coordinateArray = coordinatesString.components(separatedBy: .whitespacesAndNewlines)
        let coordinates = coordinateArray.map( { Int($0) } )
        
        if coordinates[0] == nil || coordinates[1] == nil {
            fatalError("The coordinates '\(coordinatesString)' could not be converted to integers.")
        }
        
        self.x = coordinates[0]!
        self.y = coordinates[1]!
        self.state = state
    }
}
