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
    
    weak var delegate: GameModelDelegate?
    private var table: [[GameCell]] = []
    
    private var width = 0
    private var height = 0
    
    func initGame(width: Int, height: Int) {
        self.width = width
        self.height = height
        
        table = []
        for _ in 0..<height {
            var row: [GameCell] = []
            for _ in 0..<width {
                row.append(ModelGameCell())
            }
            table.append(row)
        }
        
        placeOrganism(numberOfCells: width * height)
        
        delegate?.update(table: table)
    }
    func move() {
        for (y, row) in table.enumerated() {
            for (x, cell) in row.enumerated() {
                let environment = getEnvironment(x: x, y: y)
                cell.organism?.move(from: cell, in: environment)
            }
        }
        
        delegate?.update(table: table)
    }
    
    private func placeOrganism(numberOfCells: Int) {
        let numberOfPenguins = Int(Double(numberOfCells) * 0.5)
        let numberOfKillerWhale = Int(Double(numberOfCells) * 0.05)

        for _ in 1...numberOfPenguins {
            placePenguin()
        }

        for _ in 1...numberOfKillerWhale {
            placeKillerWhale()
        }
    }
    
    private func placePenguin() {
        while true {
            let x = Int.random(in: 0..<width)
            let y = Int.random(in: 0..<height)
            let cell = table[y][x]
            if cell.organism == nil {
                cell.organism = Penguin()
                return
            }
        }
    }

    private func placeKillerWhale() {
        while true {
            let x = Int.random(in: 0..<width)
            let y = Int.random(in: 0..<height)
            let cell = table[y][x]
            if cell.organism == nil {
                cell.organism = KillerWhale()
                return
            }
        }
    }
    
    private func getEnvironment(x: Int, y: Int) -> [GameCell?] {
        var environment: [GameCell?] = []
        for direction in Direction.allCases {
            let point = direction.offset(x: x, y: y)
            environment.append(table[point.y][point.x])
        }
        return environment
    }
}

fileprivate class ModelGameCell: GameCell {
    var organism: Organism? = nil
}
