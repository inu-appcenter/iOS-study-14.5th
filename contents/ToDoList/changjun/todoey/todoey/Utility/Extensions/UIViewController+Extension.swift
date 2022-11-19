//
//  UIViewController.swift
//  todoey
//
//  Created by 이창준 on 2022/11/13.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
