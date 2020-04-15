//
//  GameCellLabel.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class GameCellLabel: UILabel {

    init(filling: String?) {
        super.init(frame: .zero)
        text = filling
        textAlignment = .center
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
