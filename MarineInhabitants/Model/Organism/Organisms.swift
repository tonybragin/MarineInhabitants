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

class SuperOrganism: Organism {
    var name: String {
        return "SO"
    }
    
    var isMoved: Bool = false
    
    var survivedMoves = 0
    
    var movesToMultiply: Int {
        return 0
    }
    
    func move(from cell: GameCell, in environment: [GameCell?]) {
        increaseSurvivedMoves()
        tryMove(from: cell, in: environment)
        afterMove()
    }
    
    func moveEnds() {
        isMoved = false
    }
    
    func increaseSurvivedMoves() {
        survivedMoves += 1
    }
    
    func tryMove(from cell: GameCell, in environment: [GameCell?]) {
        trySwim(from: cell, in: environment)
        tryMultiply(in: environment)
    }
    
    func afterMove() {
        isMoved = true
    }
    
    func trySwim(from cell: GameCell, in environment: [GameCell?]) {
        if let newCell = getRandomFreeCell(in: environment) {
            cell.organism = nil
            newCell.organism = self
        }
    }
    
    func getRandomFreeCell(in environment: [GameCell?]) -> GameCell? {
        var choosedCell: GameCell! = nil
        while choosedCell == nil {
            let direction = Direction.init(rawValue: Int.random(in: 0..<8))!
            choosedCell = environment[direction.rawValue]
        }
        if choosedCell.organism == nil {
            return choosedCell
        }
        return nil
    }
    
    func tryMultiply(in environment: [GameCell?]) {
        guard survivedMoves == movesToMultiply else {
            return
        }
        let freeCells = environment.filter { (cell) -> Bool in
            return cell != nil && cell!.organism == nil
        }
        if !freeCells.isEmpty {
            let index = Int.random(in: 0..<freeCells.count)
            freeCells[index]!.organism = OrganismFactory.get(organism: self)
        }
    }
}
