//
//  ContentView.swift
//  Example
//
//  Created by Aaron Lee on 2020-12-17.
//

import SwiftUI
import RespondableTextField

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @State private var text1: String = ""
    @State private var text2: String = ""
    @State private var text3: String = ""
    @State private var text4: String = ""
    
    // MARK: - BODY
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .leading, spacing: 30) {
                
                // Default
                Group {
                    Text("Default")
                        .font(.system(size: 14, weight: .bold, design: .default))
                    RespondableTextField(text: $text1, tag: 0, isFirstResponder: true, placeholder: "1st") { value in
                        print("onEditing: \(value)")
                    } didBeginEditing: {
                        print("didBeginEditing")
                    } didEndEditing: {
                        print("didEndEditing")
                    } shouldReturn: { value in
                        print("shouldReturn: \(value ?? "N/A")")
                    }
                    
                    Text(text1)
                }
                
                // SecureType + RectangleLine Border
                Group {
                    Text("SecureType + RectangleLine Border")
                        .font(.system(size: 14, weight: .bold, design: .default))
                    RespondableTextField(text: $text2, tag: 1, placeholder: "2nd") { value in
                        print("onEditing: \(value)")
                    } didBeginEditing: {
                        print("didBeginEditing")
                    } didEndEditing: {
                        print("didEndEditing")
                    } shouldReturn: { value in
                        print("shouldReturn: \(value ?? "N/A")")
                    }
                    .respondableSecureType()
                    .respondableLineStyle()
                    
                    Text(text2)
                }
                
                // NumberPad + OneTimeCode + Rounded Border
                Group {
                    Text("NumberPad + OneTimeCode + Rounded Border")
                        .font(.system(size: 14, weight: .bold, design: .default))
                    RespondableTextField(text: $text3, tag: 2, placeholder: "3rd") { value in
                        print("onEditing: \(value)")
                    } didBeginEditing: {
                        print("didBeginEditing")
                    } didEndEditing: {
                        print("didEndEditing")
                    } shouldReturn: { value in
                        print("shouldReturn: \(value ?? "N/A")")
                    }
                    .respondableKeyboardType(.numberPad)
                    .respondableContentType(.oneTimeCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text(text3)
                }
                
                // didEndEditing + Bazel Border + Font
                Group {
                    Text("didBeginEditing + didEndEditing + Bazel Border")
                        .font(.system(size: 14, weight: .bold, design: .default))
                    RespondableTextField(text: $text4, tag: 3, placeholder: "4th") { value in
                        print("onEditing: \(value)")
                    } didBeginEditing: {
                        print("didBeginEditing")
                    } didEndEditing: {
                        print("didEndEditing")
                    } shouldReturn: { value in
                        print("shouldReturn: \(value ?? "N/A")")
                    }
                    .respondableBezelStyle()
                    .respondableFont(.systemFont(ofSize: 20, weight: .bold))
                    
                    Text(text4)
                }
                
            } //: V
            .padding()
        } //: S
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
