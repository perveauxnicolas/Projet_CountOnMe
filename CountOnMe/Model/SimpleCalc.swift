//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Perveaux Nicolas on 16/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import UIKit
// Use the protocol to delegate alerts and update the display (textView)
protocol simpleCalcDelegate: AnyObject {
    func displayMessageInWarningWindow(title: String, message: String)
    func displayTheResultOnTheView(label: String)
}

class SimpleCalc  {
    
    // MARK: - PROPERTIES
    // Array of number
    var stringNumbers: [String] = [String()]
    //Array of operators
    private var operators: [String] = ["+"]
    private var index = 0
    //  the delegate
    weak var simpleCalcDelegate: simpleCalcDelegate?
    // Parameter to round the result if not a decimal number
    private var resultString: String!
    //expression correctly entered by the user, otherwise it will alert the user
    var expressionIsCorrect: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    simpleCalcDelegate?.displayMessageInWarningWindow(title: "error!", message: "Start a new calculation!")
                } else {
                    simpleCalcDelegate?.displayMessageInWarningWindow(title: "error", message: "Type a correct expression!")
                }
                return false
            }
        }
        return true
    }
    //Checks that the string of numbers contains something otherwise it will warn the user to first enter a string of numbers and then add an operator.
    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                simpleCalcDelegate?.displayMessageInWarningWindow(title: "error", message: "Wrong expression!")
                return false
            }
        }
        return true
    }
    
    // MARK: - METHODS
    //update label text (display)
    private func updateDisplay() {
        var text = ""
        for (index, stringNumber) in stringNumbers.enumerated() {
            if index > 0 {
                // Add operator
                text += operators [index]
            }
            text += stringNumber
            // Add number
        }
        simpleCalcDelegate?.displayTheResultOnTheView(label: text)
    }
    // managing numbers when the user enters them
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var NewStringNumber = stringNumber
            NewStringNumber += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = NewStringNumber
        }
        updateDisplay()
    }
    
    func addNewOperator (with operators: String) {
        switch (operators) {
        case "+":
            addition()
        case "-":
            substraction()
        case "x":
            multiplication()
        case "÷":
            division()
        case "AC":
            clear()
        default: break
        }
    }
    // managing operations (+, -)
    func calculate() {
        if !expressionIsCorrect {
            return
        }
        orderOfOperations()
        var total = Double()
        for (index, stringNumber) in stringNumbers.enumerated() {
            guard let number = Double(stringNumber) else { return }
            if operators[index] == "+" {
                total += number
            } else if operators[index] == "-" {
                total -= number
            }
        }
        let result = total
        clear()
        // Round the result if no decimal needed
        roundResult(result: result)
        simpleCalcDelegate?.displayTheResultOnTheView(label: resultString)
        stringNumbers[stringNumbers.count-1] = resultString
    }
    // remove the decimal of the Double if result is an integer
    private func roundResult(result: Double) {
        let numberformatter = NumberFormatter()
        numberformatter.minimumFractionDigits = 0
        numberformatter.maximumFractionDigits = 2
        resultString = numberformatter.string(from: NSNumber(value: result))
    }
    //  managing order of operations and managing operations (*, /)
    private func orderOfOperations() {
        let priorityOperators = ["x", "÷"]
        var result: Double = 0
        var theStringNumber = 0
        while theStringNumber < stringNumbers.count - 1 {
            if var firstOperand = Double(stringNumbers[theStringNumber]) {
                while priorityOperators.contains(operators[theStringNumber + 1]) {
                    if let secondOperand = Double(stringNumbers[theStringNumber + 1]) {
                        if operators[theStringNumber + 1] == "x" {
                            result = firstOperand * secondOperand
                        } else if operators[theStringNumber + 1] == "÷" && secondOperand != 0 && firstOperand != 0 {
                            result = firstOperand / secondOperand
                        } else {
                            simpleCalcDelegate?.displayMessageInWarningWindow(title: "Error!", message: "Dividing by 0 doesn't exist!")
                            result = 0
                        }
                        stringNumbers[theStringNumber] = String(result)
                        firstOperand = result
                        stringNumbers.remove(at: theStringNumber + 1)
                        operators.remove(at: theStringNumber + 1)
                        if theStringNumber == stringNumbers.count - 1 {
                            return
                        }
                    }
                }
                theStringNumber += 1
            }
        }
    }
    // plus operator when users types it
    func addition() {
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    // minus operator when users types it
    func substraction() {
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    // divide operator when user types it
    func division() {
        if canAddOperator {
            operators.append("÷")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    // multiply operator when user types it
    func multiplication() {
        if canAddOperator {
            operators.append("x")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    // reset
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
        updateDisplay()
    }
    
}
