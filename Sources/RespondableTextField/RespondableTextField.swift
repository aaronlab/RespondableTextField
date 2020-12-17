//
//  RespondableTextField.swift
//
//
//  Created by Aaron Lee on 2020-12-17.
//

import SwiftUI

@available(iOS 13.0, *)
public struct RespondableTextField: UIViewRepresentable {
    
    // MARK: - PROPERTIES
    
    private let wrappableTextField = WrappableTextField()
    var tag: Int = 0
    var placeholder: String?
    var onEditing: ((String) -> Void)?
    var onCommitted: (() -> Void)?
    var didBeginEditing: (() -> Void)?
    var didEndEditing: ((UITextField.DidEndEditingReason) -> Void)?
    
    // MARK: - INIT
    
    public init(
        tag: Int,
        placeholder: String? = nil,
        onEditing: ((String) -> Void)? = nil,
        onCommitted: (() -> Void)? = nil,
        didBeginEditing: (() -> Void)? = nil,
        didEndEditing: ((UITextField.DidEndEditingReason) -> Void)? = nil
    ) {
        self.tag = tag
        self.placeholder = placeholder
        self.onEditing = onEditing
        self.onCommitted = onCommitted
        self.didBeginEditing = didBeginEditing
        self.didEndEditing = didEndEditing
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: UIViewRepresentableContext<RespondableTextField>) -> WrappableTextField {
        self.wrappableTextField.tag = self.tag
        self.wrappableTextField.delegate = self.wrappableTextField
        self.wrappableTextField.placeholder = self.placeholder
        self.wrappableTextField.onEditing = self.onEditing
        self.wrappableTextField.onCommitted = self.onCommitted
        self.wrappableTextField.didBeginEditing = self.didBeginEditing
        self.wrappableTextField.didEndEditing = self.didEndEditing
        return self.wrappableTextField
    }
    
    public func updateUIView(_ uiView: WrappableTextField, context: UIViewRepresentableContext<RespondableTextField>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
}

// MARK: - KEYBOARD & CONTENT

@available(iOS 13.0, *)
extension RespondableTextField {
    
    public func respondableSecureType() -> Self {
        self.wrappableTextField.isSecureTextEntry = true
        return self
    }
    
    public func respondableKeyboardType(_ type: UIKeyboardType) -> Self {
        self.wrappableTextField.keyboardType = type
        return self
    }
    
    public func respondableContentType(_ type: UITextContentType) -> Self {
        self.wrappableTextField.textContentType = type
        return self
    }
    
    public func respondableCapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.wrappableTextField.autocapitalizationType = type
        return self
    }
    
}

// MARK: - STYLES

@available(iOS 13.0, *)
extension RespondableTextField {
    
    public func respondableFont(_ font: UIFont) -> Self {
        self.wrappableTextField.font = font
        return self
    }
    
    public func respondableLineStyle() -> Self {
        self.wrappableTextField.borderStyle = .line
        return self
    }
    
    public func respondableBezelStyle() -> Self {
        self.wrappableTextField.borderStyle = .bezel
        return self
    }
    
    public func textFieldStyle<S>(_ style: S) -> some View where S: TextFieldStyle {
        if style is RoundedBorderTextFieldStyle {
            self.wrappableTextField.borderStyle = .roundedRect
        }
        if style is PlainTextFieldStyle || style is DefaultTextFieldStyle {
            self.wrappableTextField.borderStyle = .none
        }
        return self
    }
    
}
