//
//  GameTableStackView.swift
//  MarineInhabitants
//
//  Created by Tony on 15/04/2020.
//  Copyright © 2020 Tony. All rights reserved.
//

import UIKit

class GameTableStackView: UIStackView {
    
    func initGameTable(width: Int, height: Int) {
        for _ in 1...height {
            var lineViews: [UIView] = []
            for _ in 1...width {
                let label = GameCellLabel(filling: "P")
                lineViews.append(label)
            }
            let horizontalStack = UIStackView(arrangedSubviews: lineViews)
            horizontalStack.axis = .horizontal
            horizontalStack.distribution = .fillEqually
            horizontalStack.spacing = 4
            addArrangedSubview(horizontalStack)
        }
    }
}
