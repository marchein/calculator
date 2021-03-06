//
//  ViewController.swift
//  Calculator
//
//  Created by Marc Hein on 12.07.18.
//  Copyright © 2018 Marc Hein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Data
    var numberOnScreen: Double = -1
    var previousNumber: Double = -1
    var performingMath = false
    var operation = String()
    let basti = SimpleSound(named: "basti")
    
    // MARK: Outlets
    @IBOutlet weak var calculatorDisplay: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: Actions
    @IBAction func clearButton(_ sender: Any) {
        calculatorDisplay.text = "0"
        numberOnScreen = -1
        previousNumber = -1
        operation = String()
    }
    
    @IBAction func plusMinusButton(_ senderssh : UIButton) {
        numberOnScreen = Double(calculatorDisplay.text!)! * -1
        calculatorDisplay.text = String(numberOnScreen)
        removeDotZero(calculatorDisplay)
    }
    
    @IBAction func numberAction(_ sender: UIButton) {
        if performingMath {
            calculatorDisplay.text = sender.currentTitle
            numberOnScreen = Double(calculatorDisplay.text!)!
            performingMath = false
        } else {
            if calculatorDisplay.text?.count == 1 && calculatorDisplay.text == "0" {
                calculatorDisplay.text = sender.currentTitle!
            } else {
                calculatorDisplay.text = calculatorDisplay.text! + sender.currentTitle!
            }
            numberOnScreen = Double(calculatorDisplay.text!)!
        }
    }
    
    @IBAction func operationAction(_ sender: ActionUIButton) {
        let currentButtonOperation = sender.currentTitle!
        if calculatorDisplay.text! != "" && currentButtonOperation != "=" {
            previousNumber = Double(calculatorDisplay.text!)!
            operation = currentButtonOperation
            performingMath = true
        } else if currentButtonOperation == "=" {
            if previousNumber != -1 && numberOnScreen != -1 {
                switch operation {
                case "/":
                    if numberOnScreen != 0 {
                        calculatorDisplay.text = String(previousNumber / numberOnScreen)
                    } else {
                        basti.play()
                        clearButton(self)
                    }
                case "x":
                    calculatorDisplay.text = String(previousNumber * numberOnScreen)
                case "-":
                    calculatorDisplay.text = String(previousNumber - numberOnScreen)
                case "+":
                    calculatorDisplay.text = String(previousNumber + numberOnScreen)
                default:
                    fatalError("Button not defined! \(operation)")
                }
            }
        }
        removeDotZero(calculatorDisplay)
    }
    
    
    @IBAction func dotAction(_ sender: UIButton) {
        if calculatorDisplay.text!.index(of: ".") == nil {
            calculatorDisplay.text = calculatorDisplay.text! + "."
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let allButtons = getAllButtons(stackView: stackView)
        for currentButton in allButtons {
            addBorderTo(button: currentButton, width: 0.3, color: UIColor.black.cgColor)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
