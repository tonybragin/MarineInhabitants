//
//  ViewController.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameTableVerticalStack: GameTableStackView!
    private var viewModel: GameViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGestureRecognizer()
        viewModel = GameViewModel(gameTable: gameTableVerticalStack)
        viewModel.viewDidLoad()
    }
    
    private func configureTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(gameTableVerticalStackTouched))
        gameTableVerticalStack.addGestureRecognizer(tapGestureRecognizer)
    }

    @IBAction func restartButtonTouched(_ sender: UIButton) {
        viewModel.restartTouched()
    }
    @objc func gameTableVerticalStackTouched() {
        viewModel.moveTouched()
    }
}

