//
//  RespondableTextField.swift
//
//
//  Created by Aaron Lee on 2020-12-17.
//

import SwiftUI

public struct RespondableTextField: UIViewRepresentable {
    
    private let tempTextField = WrappableTextField()
    var tag: Int = 0
    
    var placeholder: String?
    var onEditing: ((String) -> Void)?
    var onCommitted: (() -> Void)?
    
    public init(tag: Int, placeholder: String? = nil, onEditing: ((String) -> Void)? = nil, onCommitted: (() -> Void)? = nil) {
        self.tag = tag
        self.placeholder = placeholder
        self.onEditing = onEditing
        self.onCommitted = onCommitted
    }
    
    public func makeUIView(context: UIViewRepresentableContext<RespondableTextField>) -> WrappableTextField {
        self.tempTextField.tag = self.tag
        self.tempTextField.delegate = self.tempTextField
        self.tempTextField.placeholder = self.placeholder
        self.tempTextField.onEditing = self.onEditing
        self.tempTextField.onCommitted = self.onCommitted
        return self.tempTextField
    }
    
    public func updateUIView(_ uiView: WrappableTextField, context: UIViewRepresentableContext<RespondableTextField>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
}

extension RespondableTextField {
    
    public func respondableSecureType() -> Self {
        self.tempTextField.isSecureTextEntry = true
        return self
    }
    
    public func respondableKeyboardType(_ type: UIKeyboardType) -> Self {
        self.tempTextField.keyboardType = type
        return self
    }
    
    public func respondableContentType(_ type: UITextContentType) -> Self {
        self.tempTextField.textContentType = type
        return self
    }
    
    public func respondableCapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.tempTextField.autocapitalizationType = type
        return self
    }
    
}
