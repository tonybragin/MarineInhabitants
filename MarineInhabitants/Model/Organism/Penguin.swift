//
//  Penguin.swift
//  MarineInhabitants
//
//  Created by Tony on 16/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

class Penguin: SuperOrganism {
    override var name: String {
        return "P"
    }
    
    override var movesToMultiply: Int {
        return 3
    }
    
    override func increaseSurvivedMoves() {
        survivedMoves = (survivedMoves + 1) % 4
    }
}
