[![Language: Swift 5](https://img.shields.io/badge/language-Swift5-orange?style=flat&logo=swift)](https://developer.apple.com/swift)
![Platform: iOS 13+](https://img.shields.io/badge/platform-iOS%2013%2B-blue?style=flat&logo=apple)
![SwiftPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen?style=flat&logo=swift)
[![License: MIT](https://img.shields.io/badge/license-MIT-lightgrey?style=flat)](https://github.com/aaronLab/SweetCardScanner/blob/main/LICENSE)
[![Release version](https://img.shields.io/badge/release-v1.0.1-blue)](https://github.com/aaronLab/RespondableTextField/releases/tag/v1.0.0)

# RespondableTextField

`RespondableTextField` is a simple textField library for SwiftUI. The reason why I wanted to make this library was because I was too lazy to make `UIViewRepresentable`views every single time. Also, I know you were really struggling from, or tired of taking care of UITextFieldDelegate methods, such as `becomeFirstResponder`, `resignFirstResponder`. I really hope this helps you.

<img src="./preview.png" width="260">

## Requirements

- iOS 13.0+ (due to SwiftUI)

## Installation

- In Xcode, add the URL of this repository in SwiftPM:

  ```http
  https://github.com/aaronLab/RespondableTextField.git
  ```

## Usage

- `import RespondableTextField`
- Add `RespondableTextField` in your body like below.
- **_⚠️ To make it work properly: The tags of each RespondableTextField in each body must be increased SEQUENTIALLY in order. ⚠️_**

  ```Swift
  RespondableTextField(
    text: Binding<String>,
    tag: Int,
    isFirstResponder: Bool = false,
    placeholder: String? = nil,
    onEditing: ((String) -> Void)? = nil,
    didBeginEditing: (() -> Void)? = nil,
    didEndEditing: (() -> Void)? = nil,
    shouldReturn: ((String?) -> Void)? = nil
  )
  ```

- Also, you don't have to fill all of the optional parameters or `isFirstResponder`.
- You can make the textField the first responder with `isFirstResponder = true`.

## Example

You can use or customize RespondableTextField like below, or [see example file](./Example/Example/ContentView.swift).

```Swift
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

```

## License

Licensed under [MIT](./LICENSE)
