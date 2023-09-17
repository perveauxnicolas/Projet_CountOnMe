//
//  UIViewController.swift
//  CountOnMe
//
//  Created by Perveaux Nicolas on 06/09/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import UIKit

extension UIViewController {
    // showing alerts to user when user's inputs are wrong
    func updateShowAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
