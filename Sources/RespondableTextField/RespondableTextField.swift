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
    
    private let textField = UITextField(frame: .zero)
    
    @Binding var text: String
    let isFirstResponder: Bool
    let tag: Int
    let placeholder: String?
    let onEditing: ((String) -> Void)?
    let didBeginEditing: (() -> Void)?
    let didEndEditing: (() -> Void)?
    let shouldReturn: ((String?) -> Void)?
    
    // MARK: - INIT
    
    public init(
        text: Binding<String>,
        tag: Int,
        isFirstResponder: Bool = false,
        placeholder: String? = nil,
        onEditing: ((String) -> Void)? = nil,
        didBeginEditing: (() -> Void)? = nil,
        didEndEditing: (() -> Void)? = nil,
        shouldReturn: ((String?) -> Void)? = nil
    ) {
        self._text = text
        self.tag = tag
        self.isFirstResponder = isFirstResponder
        self.placeholder = placeholder
        self.onEditing = onEditing
        self.didBeginEditing = didBeginEditing
        self.didEndEditing = didEndEditing
        self.shouldReturn = shouldReturn
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(context: UIViewRepresentableContext<RespondableTextField>) -> UITextField {
        self.textField.tag = self.tag
        self.textField.placeholder = self.placeholder
        self.textField.delegate = context.coordinator
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<RespondableTextField>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.text = self.text
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }
    
}

// MARK: - COORDINATOR

@available(iOS 13.0, *)
extension RespondableTextField {
    
    public func makeCoordinator() -> RespondableTextField.Coordinator {
        return Coordinator(text: $text, tag: tag, isFirstResponder: isFirstResponder, placeholder: placeholder, onEditing: onEditing, didBeginEditing: didBeginEditing, didEndEditing: didEndEditing, shouldReturn: shouldReturn)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        
        // MARK: - PROPERTIES
        
        @Binding var text: String
        let isFirstResponder: Bool
        let tag: Int
        var didBecomeFirstResponder = false
        let placeholder: String?
        let onEditing: ((String) -> Void)?
        let didBeginEditing: (() -> Void)?
        let didEndEditing: (() -> Void)?
        let shouldReturn: ((String?) -> Void)?
        
        // MARK: - INIT
        
        public init(
            text: Binding<String>,
            tag: Int,
            isFirstResponder: Bool = false,
            placeholder: String? = nil,
            onEditing: ((String) -> Void)? = nil,
            didBeginEditing: (() -> Void)? = nil,
            didEndEditing: (() -> Void)? = nil,
            shouldReturn: ((String?) -> Void)? = nil
        ) {
            self._text = text
            self.tag = tag
            self.isFirstResponder = isFirstResponder
            self.placeholder = placeholder
            self.onEditing = onEditing
            self.didBeginEditing = didBeginEditing
            self.didEndEditing = didEndEditing
            self.shouldReturn = shouldReturn
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.text = textField.text ?? ""
            }
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            self.didBeginEditing?()
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            self.didEndEditing?()
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let next = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                next.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            shouldReturn?(textField.text)
            return false
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                self.onEditing?(updatedText)
            }
            return true
        }
        
    }
    
}

// MARK: - KEYBOARD & CONTENT

@available(iOS 13.0, *)
extension RespondableTextField {
    
    public func respondableSecureType() -> Self {
        self.textField.isSecureTextEntry = true
        return self
    }
    
    public func respondableKeyboardType(_ type: UIKeyboardType) -> Self {
        self.textField.keyboardType = type
        return self
    }
    
    public func respondableContentType(_ type: UITextContentType) -> Self {
        self.textField.textContentType = type
        return self
    }
    
    public func respondableCapitalization(_ type: UITextAutocapitalizationType) -> Self {
        self.textField.autocapitalizationType = type
        return self
    }
    
}

// MARK: - STYLES

@available(iOS 13.0, *)
extension RespondableTextField {
    
    public func respondableFont(_ font: UIFont) -> Self {
        self.textField.font = font
        return self
    }
    
    public func respondableLineStyle() -> Self {
        self.textField.borderStyle = .line
        return self
    }
    
    public func respondableBezelStyle() -> Self {
        self.textField.borderStyle = .bezel
        return self
    }
    
    public func textFieldStyle<S>(_ style: S) -> some View where S: TextFieldStyle {
        if style is RoundedBorderTextFieldStyle {
            self.textField.borderStyle = .roundedRect
        }
        if style is PlainTextFieldStyle || style is DefaultTextFieldStyle {
            self.textField.borderStyle = .none
        }
        return self
    }
    
}
