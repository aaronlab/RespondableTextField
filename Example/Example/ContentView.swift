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
        VStack(alignment: .leading, spacing: 30) {
            
            // Default
            Group {
                Text("Default")
                    .font(.system(size: 14, weight: .bold, design: .default))
                RespondableTextField(tag: 0, placeholder: "First TextField") { value in
                    self.text1 = value
                } onCommitted: {
                    print(self.text1)
                }
                Text(text1)
            }
            
            // SecureType + RectangleLine Border
            Group {
                Text("SecureType + RectangleLine Border")
                    .font(.system(size: 14, weight: .bold, design: .default))
                RespondableTextField(tag: 1, placeholder: "Second TextField") { value in
                    self.text2 = value
                }
                .respondableSecureType()
                .respondableLineStyle()
                
                Text(text2)
            }
            
            // NumberPad + OneTimeCode + Rounded Border
            Group {
                Text("NumberPad + OneTimeCode + Rounded Border")
                    .font(.system(size: 14, weight: .bold, design: .default))
                RespondableTextField(tag: 2, placeholder: "Third TextField") { value in
                    self.text3 = value
                } onCommitted: {
                    print(self.text3)
                }
                .respondableKeyboardType(.numberPad)
                .respondableContentType(.oneTimeCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(text3)
            }
            
            // didBeginEditing + didEndEditing + Bazel Border + Font
            Group {
                Text("didBeginEditing + didEndEditing + Bazel Border")
                    .font(.system(size: 14, weight: .bold, design: .default))
                RespondableTextField(tag: 3, placeholder: "Fourth TextField") { value in
                    self.text4 = value
                } didBeginEditing: {
                    print("Begin")
                } didEndEditing: { _ in
                    print("Done")
                }
                .respondableBezelStyle()
                .respondableFont(.systemFont(ofSize: 20, weight: .bold))
            }
            
        } //: V
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
