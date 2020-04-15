//
//  ViewModel.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

protocol GameViewModelProtocol {
    init(gameTable: GameTable)
    func viewDidLoad()
    func moveTouched()
    func restartTouched()
}

class GameViewModel: GameViewModelProtocol, GameModelDelegate {
    
    private unowned var gameTable: GameTable
    private var model: GameModelProtocol
    
    private let gameTableHeight = 15
    private let gameTableWidth = 10
    
    required init(gameTable: GameTable) {
        self.gameTable = gameTable
        model = GameModel()
        model.delegate = self
    }
    
    func viewDidLoad() {
        gameTable.initGameTable(width: gameTableWidth, height: gameTableHeight)
        model.initGame(width: gameTableWidth, height: gameTableHeight)
    }
    func moveTouched() {
        model.move()
    }
    func restartTouched() {
        model.initGame(width: gameTableWidth, height: gameTableHeight)
    }
    
    func update(table: [[GameCell]]) {
        gameTable.show(table: table)
    }
}
