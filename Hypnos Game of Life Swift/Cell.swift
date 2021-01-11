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

    public init(x: Int, y: Int, state: State = .dead) {
        self.x = x
        self.y = y
        self.state = state
    }
}
