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
    var operators: [String] = [String()]     //Array of operators
    var index = 0
    var simpleCalcDelegate: simpleCalcDelegate?     //  the delegate
    
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
   
    var canAddOperator: Bool {  //Checks that the string of numbers contains something, otherwise it will warn the user to first enter a string of numbers and then add an operator.
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
          //  case "=":
          //  calculate()
           // return
            case "AC":
            clear()
            default: break
        }
          //  updateDisplay()
        
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
        
        let result = String(format: "%g", total)    //"%.2f"
        simpleCalcDelegate?.updateTextView(label: result)
       // clear()
    }
        
    
    func orderOfOperations() {      //  managing order of operations and managing operations (*, /)
            let priorityOperators = ["x", "÷"]
            var result: Double = 0
            var i = 0
            while i < stringNumbers.count - 1 {
                if var firstOperand = Double(stringNumbers[i]) {
                    while priorityOperators.contains(operators[i + 1]) {
                        if let secondOperand = Double(stringNumbers[i + 1]) {
                            if operators[i + 1] == "x" {
                                result = firstOperand * secondOperand
                            } else if operators[i + 1] == "÷" && secondOperand != 0 && firstOperand != 0 {
                                result = firstOperand / secondOperand
                            } else {
                                simpleCalcDelegate?.alertMessage(title: "Error!", message: "Dividing by 0 doesn't exist!")
                                result = 0
                            }
                            stringNumbers[i] = String(result)
                            firstOperand = result
                            stringNumbers.remove(at: i + 1)
                            operators.remove(at: i + 1)
                            if i == stringNumbers.count - 1 {
                                return
                            }
                        }
                    }
                    i += 1
                }
            }
    }
    
     func addition() {                     // plus operator when users types it
        if canAddOperator {
           //operators.insert("+", at: 0)
            operators.append("+")
            stringNumbers.append("")
            updateDisplay()
        }
    }
    
    func substraction() {                  // minus operator when users types it
            if canAddOperator {
                operators.append("-")
                stringNumbers.append("")
                updateDisplay()
            }
    }
    
    func division() {                   // divide operator when user types it
            if canAddOperator {
                operators.append("÷")
                stringNumbers.append("")
                updateDisplay()
            }
    }
    
    func multiplication() {           // multiply operator when user types it
            if canAddOperator {
                operators.append("x")
                stringNumbers.append("")
                updateDisplay()
            }
    }

    func clear() {                         // reset
        stringNumbers = [String()]
        operators = [String()]
        index = 0
        updateDisplay()
    }
    
}