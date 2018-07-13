//
//  AnotherActionUIButton.swift
//  Calculator
//
//  Created by Marc Hein on 12.07.18.
//  Copyright © 2018 Marc Hein. All rights reserved.
//

import UIKit

class AnotherActionUIButton: UIButton {
    let buttonColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = buttonColor
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0) : buttonColor
        }
    }
}
