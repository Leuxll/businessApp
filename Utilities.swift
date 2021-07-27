//
//  Utilities.swift
//  businessApp
//
//  Created by Yue Fung Lee on 17/6/2021.
//

import Foundation
import UIKit

class Utilities {
    
    static func customButton(_ b: UIButton) {
        b.translatesAutoresizingMaskIntoConstraints = false
        b.titleLabel?.font = UIFont(name: FontConstants.boldFont, size: 16)
        b.layer.cornerRadius = 10
        b.layer.shadowOffset = CGSize(width: 8, height: 12)
        b.layer.shadowOpacity = 0.5
        b.layer.shadowColor = ColourConstants.ShadowColour.cgColor
        b.layer.shouldRasterize = true
        b.layer.rasterizationScale = UIScreen.main.scale
    }
    
    static func customTextField(_ v: UITextField) {
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.backgroundColor = ColourConstants.LightColour.cgColor
        v.textColor = ColourConstants.textColour().placeHolderColour
        v.layer.cornerRadius = 10
        v.layer.shadowOffset = CGSize(width: 8, height: 12)
        v.layer.shadowOpacity = 0.5
        v.layer.shadowColor = ColourConstants.ShadowColour.cgColor
        v.layer.shouldRasterize = true
        v.layer.rasterizationScale = UIScreen.main.scale
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: v.frame.height))
        v.leftView = paddingView
        v.leftViewMode = UITextField.ViewMode.always
        
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func cleanString(_ v: UITextField) -> String? {
        let cleanString = v.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanString
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
