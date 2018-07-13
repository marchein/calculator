//
//  TodayViewController.swift
//  Calculator Widget
//
//  Created by Marc Hein on 12.07.18.
//  Copyright © 2018 Marc Hein. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    // MARK: Data
    var numberOnScreen: Double = -1
    var previousNumber: Double = -1
    var performingMath = false
    var operation = String()
    let basti = SimpleSound(named: "basti")

    
    @IBOutlet weak var calculatorDisplay: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBAction func displayLongPressGesture(_ sender: Any) {
        print("long press")
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
    
    @IBAction func operationAction(_ sender: UIButton) {
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
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        let allButtons = getAllButtons(stackView: stackView)
        for currentButton in allButtons {
            addBorderTo(button: currentButton, width: 0.5, color: UIColor.black.cgColor)
        }
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        let expanded = activeDisplayMode == .expanded
        preferredContentSize = expanded ? CGSize(width: maxSize.width, height: 200) : maxSize
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}
