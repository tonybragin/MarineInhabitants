//
//  Penguin.swift
//  MarineInhabitants
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class Penguin: Organism {
    
    // MARK: - Constants
    
    var name: String {
        return "P"
    }
    
    // MARK: - Properties
    
    private var survivedMoves = 0
    private(set) var isMoved = false
    
    // MARK: - Public
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        survivedMoves = (survivedMoves + 1) % 4
        trySwim(from: cell, in: environment)
        tryMultiply(in: environment)
        isMoved = true
    }
    
    func moveEnds() {
        isMoved = false
    }
    
    // MARK: - Utility
    
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
}
