//
//  GameModel.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol GameModelDelegate: class {
    func update(table: [[GameCell]])
}

protocol GameModelProtocol {
    var delegate: GameModelDelegate? { get set }
    
    func initGame(width: Int, height: Int)
    func move()
}

class GameModel: GameModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: GameModelDelegate?
    private var table: [[GameCell]] = []
    private var width = 0
    private var height = 0
    
    // MARK: - Generation
    
    func initGame(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        table = getTable()
        placeOrganisms(numberOfCells: width * height)
        
        delegate?.update(table: table)
    }
    
    private func getTable() -> [[GameCell]] {
        let newTable: [[GameCell]] = []
        
        for _ in 0..<height {
            var row: [GameCell] = []
            for _ in 0..<width {
                row.append(ModelGameCell())
            }
            table.append(row)
        }
        
        return newTable
    }
    
    private func placeOrganisms(numberOfCells: Int) {
        let numberOfPenguins = Int(Double(numberOfCells) * 0.5)
        let numberOfKillerWhale = Int(Double(numberOfCells) * 0.05)

        for _ in 1...numberOfPenguins {
            placeOrganism(organism: .penguin)
        }

        for _ in 1...numberOfKillerWhale {
            placeOrganism(organism: .killerWhale)
        }
    }
    
    private func placeOrganism(organism: OrganismFactory.Organisms) {
        while true {
            let x = Int.random(in: 0..<width)
            let y = Int.random(in: 0..<height)
            let cell = table[y][x]
            if cell.organism == nil {
                cell.organism = OrganismFactory.get(organism: organism)
                return
            }
        }
    }
    
    // MARK: - Moving
    
    func move() {
        for (y, row) in table.enumerated() {
            for (x, cell) in row.enumerated() {
                if let organism = cell.organism, !organism.isMoved {
                    let environment = getEnvironment(x: x, y: y)
                    organism.move(from: cell, in: environment)
                }
            }
        }
        moveEnds()
        delegate?.update(table: table)
    }
    
    private func getEnvironment(x: Int, y: Int) -> [GameCell?] {
        var environment: [GameCell?] = []
        for direction in Direction.allCases {
            let point = direction.offset(x: x, y: y)
            if 0..<width ~= point.x, 0..<height ~= point.y {
                environment.append(table[point.y][point.x])
            } else {
                environment.append(nil)
            }
        }
        return environment
    }
    
    private func moveEnds() {
        table.forEach { (row) in
            row.forEach { (cell) in
                cell.organism?.moveEnds()
            }
        }
    }
}

fileprivate class ModelGameCell: GameCell {
    var organism: Organism? = nil
}
