//
//  OrganismFactory.swift
//  MarineInhabitants
//
//  Created by Tony on 17/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

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
    
    static func get(organism: Organism) -> Organism? {
        switch organism {
        case is Penguin:
            return get(organism: .penguin)
        case is KillerWhale:
            return get(organism: .killerWhale)
        default:
            return nil
        }
    }
}
