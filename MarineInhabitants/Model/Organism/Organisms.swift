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

class OrganismFactory {
    
    enum Organisms {
        case penguin
        case killerWhale
    }
    
    static func get(organism: Organisms) -> Organism {
        switch organism {
        case .penguin: return Penguin()
        case .killerWhale: return KillerWhale()
        }
    }
}
