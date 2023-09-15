//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: UIButton!
    @IBOutlet var operatorButtons: UIButton!
    
    // MARK: - Properties
    var simpleCalc = SimpleCalc()
    
    // MARK: - View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleCalc.simpleCalcDelegate = self
    }
    
    // MARK: - ACTIONS
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        simpleCalc.addNewNumber(sender.tag)
    }
    
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operators = sender.title(for: .normal) else { return }         //   guard let operators = sender.titleLabel?.text else { return }
        simpleCalc.addNewOperator(with: operators)
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        simpleCalc.calculate()
    }
    
    
}

    // MARK: - EXTENSION
    //Using extension with protocol(Model) to delegate, in order to manage alerts and update the display, to the model
    extension ViewController: simpleCalcDelegate {
        func alertMessage(title: String, message: String) {
            updateShowAlert(title: title, message: message)
        }

        func updateTextView(label: String) {
            textView.text = label
        }
    }
