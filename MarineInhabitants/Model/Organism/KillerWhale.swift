//
//  KillerWhale.swift
//  MarineInhabitants
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class KillerWhale: SuperOrganism {

    override var name: String {
        return "KW"
    }
    
    override var movesToMultiply: Int {
        return 8
    }
    
    private var hungryMoves = 0
    
    override func increaseSurvivedMoves() {
        survivedMoves = (survivedMoves + 1) % 9
    }
    
    override func trySwim(from cell: GameCell, in environment: [GameCell?]) {
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
            return
        }
        hungryMoves += 1
        if hungryMoves == 3 {
            cell.organism = nil
            return
        }
        super.trySwim(from: cell, in: environment)
    }
}
