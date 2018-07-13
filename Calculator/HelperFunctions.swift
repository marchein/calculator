//
//  HelperFunctions.swift
//  Calculator
//
//  Created by Marc Hein on 13.07.18.
//  Copyright © 2018 Marc Hein. All rights reserved.
//

import UIKit

func removeDotZero(_ calculatorDisplay: UILabel) {
    if calculatorDisplay.text!.hasSuffix(".0") {
        let endIndex = calculatorDisplay.text!.index(calculatorDisplay.text!.endIndex, offsetBy: -2)
        calculatorDisplay.text = String(calculatorDisplay.text![..<endIndex])
    }
}

func getAllButtons(stackView: UIStackView) -> [UIButton] {
    var buttons = [UIButton]()
    for subStackView in stackView.subviews {
        for subView in subStackView.subviews {
            if subView is UIButton {
                buttons.append(subView as! UIButton)
            }
        }
    }
    return buttons
}

func addBorderTo(button: UIButton, width: CGFloat, color: CGColor) {
    button.layer.borderWidth = width
    button.layer.borderColor = color
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
