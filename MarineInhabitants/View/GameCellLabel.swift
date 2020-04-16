//
//  GameCellLabel.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class GameCellLabel: UILabel, GameCell {
    
    // MARK: - Properties
    
    var organism: Organism? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.text = self?.organism?.name
            }
        }
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        textAlignment = .center
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
