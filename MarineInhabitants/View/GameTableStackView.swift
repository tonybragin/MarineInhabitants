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
    
    // MARK: - Properties
    
    private var gameTableWidth = 10
    private var gameTableHeight = 15
    
    // MARK: - Public
    
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
    
    // MARK: - Utility
    
    private func getCell(x: Int, y: Int) -> GameCell? {
        guard 0..<gameTableWidth ~= x,
            0..<gameTableHeight ~= y else {
            return nil
        }
        let yStack = arrangedSubviews[y] as! UIStackView
        return (yStack.arrangedSubviews[x] as! GameCell)
    }
}
