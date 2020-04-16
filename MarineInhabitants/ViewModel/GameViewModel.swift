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
    
    // MARK: - Constants
    
    private let gameTableHeight = 15
    private let gameTableWidth = 10
    
    // MARK: - Properties
    
    private unowned var gameTable: GameTable
    private var model: GameModelProtocol
    
    // MARK: - Initialization
    
    required init(gameTable: GameTable) {
        self.gameTable = gameTable
        model = GameModel()
        model.delegate = self
    }
    
    // MARK: - Public
    
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
