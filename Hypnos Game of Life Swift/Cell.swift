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

    public init(coordinates: String, state: State = .alive) {
        let line = coordinates.trimmingCharacters(in: .whitespacesAndNewlines)
        let coordinateArray = line.components(separatedBy: .whitespacesAndNewlines)
        let coordinates = coordinateArray.map( { Int($0)! } )
        
        self.x = coordinates[0]
        self.y = coordinates[1]
        self.state = state
    }
}
