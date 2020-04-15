//
//  Direction.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

enum Direction: Int, CaseIterable {
    case upLeft
    case up
    case upRight
    case left
    case right
    case downLeft
    case down
    case downRight
    
    func offset(x: Int, y: Int) -> (x: Int, y: Int) {
        switch self {
        case .upLeft: return (x - 1, y - 1)
        case .up: return (x, y - 1)
        case .upRight: return (x + 1, y - 1)
        case .left: return (x - 1, y)
        case .right: return (x + 1, y)
        case .downLeft: return (x - 1, y + 1)
        case .down: return (x, y + 1)
        case .downRight: return (x + 1, y + 1)
        }
    }
}
