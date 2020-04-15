//
//  ViewController.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let gameTableHeight = 15
    private let gameTableWidth = 10
    
    @IBOutlet weak var gameTableVerticalStack: GameTableStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameTableVerticalStack.initGameTable(width: gameTableWidth, height: gameTableHeight)
    }


}

