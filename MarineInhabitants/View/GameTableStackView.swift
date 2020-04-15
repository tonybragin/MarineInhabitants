//
//  GameTableStackView.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

protocol GameTable: class {
    func initGameTable(width: Int, height: Int)
    func show(table: [[GameCell]])
}

class GameTableStackView: UIStackView, GameTable {
    
    private var gameTableWidth = 10
    private var gameTableHeight = 15
    
    func initGameTable(width: Int, height: Int) {
        gameTableWidth = width
        gameTableHeight = height
        for _ in 1...height {
            var lineViews: [UIView] = []
            for _ in 1...width {
                let label = GameCellLabel()
                lineViews.append(label)
            }
            let horizontalStack = UIStackView(arrangedSubviews: lineViews)
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 4
            addArrangedSubview(horizontalStack)
        }
    }
    
    func show(table: [[GameCell]]) {
        for (y, row) in table.enumerated() {
            for (x, cell) in row.enumerated() {
                if let cellView = getCell(x: x, y: y) {
                    cellView.organism = cell.organism
                } else {
                    print("Unwrapping Error: GameTableStackView.getCell(x: \(x), y: \(y)")
                }
                
            }
        }
    }
    
    private func getCell(x: Int, y: Int) -> GameCell? {
        guard 0..<gameTableWidth ~= x,
            0..<gameTableHeight ~= y else {
            return nil
        }
        let yStack = arrangedSubviews[y] as! UIStackView
        return (yStack.arrangedSubviews[x] as! GameCell)
    }
    
//    func performMove() {
//        for y in 0..<gameTableHeight {
//            let yStack = arrangedSubviews[y] as! UIStackView
//            for x in 0..<gameTableWidth {
//                let cell = yStack.arrangedSubviews[x] as! GameCell
//                cell.organism?.move(from: cell, in: getEnvironment(x: x, y: y))
//            }
//        }
//    }
//
//    private func placeOrganism() {
//        let numberOfCells = gameTableWidth * gameTableHeight
//        let numberOfPenguins = Int(Double(numberOfCells) * 0.5)
//        let numberOfKillerWhale = Int(Double(numberOfCells) * 0.05)
//
//        for _ in 1...numberOfPenguins {
//            placePenguin()
//        }
//
//        for _ in 1...numberOfKillerWhale {
//            placeKillerWhale()
//        }
//    }
//
//    private func placePenguin() {
//        while true {
//            let x = Int.random(in: 0..<gameTableWidth)
//            let y = Int.random(in: 0..<gameTableHeight)
//            let cell = getCell(x: x, y: y)!
//            if cell.organism == nil {
//                cell.organism = Penguin()
//                return
//            }
//        }
//    }
//
//    private func placeKillerWhale() {
//        while true {
//            let x = Int.random(in: 0..<gameTableWidth)
//            let y = Int.random(in: 0..<gameTableHeight)
//            let cell = getCell(x: x, y: y)!
//            if cell.organism == nil {
//                cell.organism = KillerWhale()
//                return
//            }
//        }
//    }
//
//
//
//    private func getEnvironment(x: Int, y: Int) -> [GameCell?] {
//        var environment: [GameCell?] = []
//        for direction in Direction.allCases {
//            environment.append(getCell(x: direction.xOffset, y: direction.yOffset))
//        }
//        return environment
//    }
}
