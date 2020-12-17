//
//  WrappableTextField.swift
//  
//
//  Created by Aaron Lee on 2020-12-17.
//

import UIKit

@available(iOS 13.0, *)
public class WrappableTextField: UITextField {
    
    // MARK: - PROPERTIES
    
    var onEditing: ((String) -> Void)?
    var onCommitted: (() -> Void)?
    var didBeginEditing: (() -> Void)?
    var didEndEditing: ((UITextField.DidEndEditingReason) -> Void)?
    
}

// MARK: - UITextFieldDelegate

@available(iOS 13.0, *)
extension WrappableTextField: UITextFieldDelegate {
    
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
            self.onEditing?(newVal as String)
        }
        return true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.onCommitted?()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.didBeginEditing?()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.didEndEditing?(reason)
    }
    
}
