//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Perveaux Nicolas on 16/08/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import UIKit

protocol simpleCalcDelegate {   // Use the protocol to delegate alerts and update the display (textView)
    func alertMessage(title: String, message: String)
    func updateTextView(label: String)
}

class SimpleCalc  {
    
    // MARK: - PROPERTIES
    var stringNumbers: [String] = [String()] // Array of number
    var operators: [String] = ["+"]     //Array of operators
    var index = 0
    var simpleCalcDelegate: simpleCalcDelegate?     //  the delegate
    var resultString:String! // Parameter to round the result if not a decimal number

    var expressionIsCorrect: Bool {   //expression correctly entered by the user, otherwise it will alert the user
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    simpleCalcDelegate?.alertMessage(title: "error!", message: "Start a new calculation!")
                } else {
                    simpleCalcDelegate?.alertMessage(title: "error", message: "Type a correct expression!")
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
                simpleCalcDelegate?.alertMessage(title: "error", message: "Wrong expression!")
                return false
            }
        }
        return true
    }
    
    // MARK: - METHODS
    
    func updateDisplay() {   //update label text (display)
            var text = ""
            for (index, stringNumber) in stringNumbers.enumerated() {
               if index > 0 {       // Add operator
                text += operators [index]
                }
                text += stringNumber    // Add number
            }
            simpleCalcDelegate?.updateTextView(label: text)
        }
    
    func addNewNumber(_ newNumber: Int) {   // managing numbers when the user enters them
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

    func calculate() {                       // managing operations (+, -)
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
        roundResult(result: result)    // Round the result if no decimal needed
        simpleCalcDelegate?.updateTextView(label: resultString)
        stringNumbers[stringNumbers.count-1] = resultString
         }
        
    func roundResult(result: Double) { // remove the decimal of the Double if result is an integer
        if result == Double(Int(result)) {
            let roundResult = Int(result)
            resultString = String(roundResult)
        } else {
            resultString = String(format:"%.2f", result)
        }
    }

    func orderOfOperations() {      //  managing order of operations and managing operations (*, /)
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
                                simpleCalcDelegate?.alertMessage(title: "Error!", message: "Dividing by 0 doesn't exist!")
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
    
     func addition() {      // plus operator when users types it
        if canAddOperator {
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }

    func substraction() {   // minus operator when users types it
        if canAddOperator {
            operators.append("-")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func division() {   // divide operator when user types it
        if canAddOperator {
            operators.append("÷")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func multiplication() { // multiply operator when user types it
        if canAddOperator {
            operators.append("x")
            stringNumbers.append("")
            updateDisplay()
        }
    }

    func clear() {  // reset
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
        updateDisplay()
    }
    
}
