//
//  ActionUIButton.swift
//  Calculator
//
//  Created by Marc Hein on 12.07.18.
//  Copyright © 2018 Marc Hein. All rights reserved.
//

import UIKit

class ActionUIButton: UIButton {
    let buttonColor = UIColor.orange
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = buttonColor
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0) : buttonColor
        }
    }
}
