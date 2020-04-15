//
//  Organisms.swift
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
    
    var xOffset: Int {
        switch self {
        case .upLeft: return self.rawValue - 1
        case .up: return self.rawValue
        case .upRight: return self.rawValue + 1
        case .left: return self.rawValue - 1
        case .right: return self.rawValue + 1
        case .downLeft: return self.rawValue - 1
        case .down: return self.rawValue
        case .downRight: return self.rawValue + 1
        }
    }
    
    var yOffset: Int {
        switch self {
        case .upLeft: return self.rawValue - 1
        case .up: return self.rawValue - 1
        case .upRight: return self.rawValue - 1
        case .left: return self.rawValue
        case .right: return self.rawValue
        case .downLeft: return self.rawValue + 1
        case .down: return self.rawValue + 1
        case .downRight: return self.rawValue + 1
        }
    }
}

protocol Organism {
    var name: String { get }
    func move(from cell: GameCell, in environment: [GameCell?])
}

protocol GameCell: class {
    var organism: Organism? { get set }
}

class Penguin: Organism {
    
    var name: String {
        return "P"
    }
    
    private var survivedMoves = 0
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        survivedMoves = (survivedMoves + 1) % 4
        trySwim(in: environment)
        tryMultiply(in: environment)
    }
    
    private func trySwim(in environment: [GameCell?]) {
        var choosedCell: GameCell! = nil
        while choosedCell == nil {
            let direction = Direction.init(rawValue: Int.random(in: 0..<8))!
            choosedCell = environment[direction.rawValue]
        }
        if choosedCell.organism == nil {
            choosedCell.organism = self
        }
    }
    private func tryMultiply(in environment: [GameCell?]) {
        guard survivedMoves == 3 else {
            return
        }
        let freeCells = environment.filter { (cell) -> Bool in
            return cell != nil && cell!.organism == nil
        }
        if !freeCells.isEmpty {
            let index = Int.random(in: 0..<freeCells.count)
            freeCells[index]!.organism = Penguin()
        }
    }
}

class KillerWhale: Organism {
    
    var name: String {
        return "KW"
    }
    
    private var survivedMoves = 0
    private var hungryMoves = 0
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        survivedMoves = (survivedMoves + 1) % 9
        trySwim(in: environment)
        tryMultiply(on: cell, in: environment)
    }
    private func trySwim(in environment: [GameCell?]) {
        let penguinCells = environment.filter { (cell) -> Bool in
            if let _ = cell?.organism as? Penguin {
                return true
            } else {
                return false
            }
        }
        if let penguinCell = penguinCells.first {
            penguinCell!.organism = self
            hungryMoves = 0
            return
        }
        hungryMoves += 1
        var choosedCell: GameCell! = nil
        while choosedCell == nil {
            let direction = Direction.init(rawValue: Int.random(in: 0..<8))!
            choosedCell = environment[direction.rawValue]
        }
        if choosedCell.organism == nil {
            choosedCell.organism = self
        }
    }
    private func tryMultiply(on cell: GameCell, in environment: [GameCell?]) {
        if survivedMoves == 3 {
            cell.organism = nil
            return
        }
        if survivedMoves == 8 {
            let freeCells = environment.filter { (cell) -> Bool in
                return cell != nil && cell!.organism == nil
            }
            if !freeCells.isEmpty {
                let index = Int.random(in: 0..<freeCells.count)
                freeCells[index]!.organism = KillerWhale()
            }
        }
    }
}
