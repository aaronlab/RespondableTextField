//
//  WrappableTextField.swift
//  
//
//  Created by Aaron Lee on 2020-12-17.
//

import UIKit

public class WrappableTextField: UITextField, UITextFieldDelegate {
    
    var onEditing: ((String) -> Void)?
    var onCommitted: (() -> Void)?
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            next.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let val = textField.text as NSString? {
            let newVal = val.replacingCharacters(in: range, with: string)
            onEditing?(newVal as String)
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onCommitted?()
    }
    
}
