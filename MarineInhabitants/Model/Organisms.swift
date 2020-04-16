//
//  Organisms.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol Organism {
    var name: String { get }
    var isMoved: Bool { get }
    func move(from cell: GameCell, in environment: [GameCell?])
    func moveEnds()
}

class Penguin: Organism {
    
    var name: String {
        return "P"
    }
    
    private var survivedMoves = 0
    private(set) var isMoved = false
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        survivedMoves = (survivedMoves + 1) % 4
        trySwim(from: cell, in: environment)
        tryMultiply(in: environment)
        isMoved = true
    }
    
    private func trySwim(from cell: GameCell, in environment: [GameCell?]) {
        var choosedCell: GameCell! = nil
        while choosedCell == nil {
            let direction = Direction.init(rawValue: Int.random(in: 0..<8))!
            choosedCell = environment[direction.rawValue]
        }
        if choosedCell.organism == nil {
            cell.organism = nil
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
    
    func moveEnds() {
        isMoved = false
    }
}

class KillerWhale: Organism {
    
    var name: String {
        return "KW"
    }
    
    private var survivedMoves = 0
    private var hungryMoves = 0
    private(set) var isMoved = false
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        survivedMoves = (survivedMoves + 1) % 9
        if let newCell = trySwim(from: cell, in: environment) {
            tryMultiply(on: newCell, in: environment)
        }
        isMoved = true
    }
    private func trySwim(from cell: GameCell, in environment: [GameCell?]) -> GameCell? {
        let penguinCells = environment.filter { (cell) -> Bool in
            if let _ = cell?.organism as? Penguin {
                return true
            } else {
                return false
            }
        }
        if let penguinCell = penguinCells.first {
            cell.organism = nil
            penguinCell!.organism = self
            hungryMoves = 0
            return penguinCell
        }
        hungryMoves += 1
        if hungryMoves == 3 {
            cell.organism = nil
            return nil
        }
        var choosedCell: GameCell! = nil
        while choosedCell == nil {
            let direction = Direction.init(rawValue: Int.random(in: 0..<8))!
            choosedCell = environment[direction.rawValue]
        }
        if choosedCell.organism == nil {
            cell.organism = nil
            choosedCell.organism = self
            return choosedCell
        }
        return cell
    }
    private func tryMultiply(on cell: GameCell, in environment: [GameCell?]) {
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
    
    func moveEnds() {
        isMoved = false
    }
}
