//
//  NameInputView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

struct NameInputView: View {
    @Binding var name: String?
    var placeholder: String
    var isNameCorrect: Bool
    
    var body: some View {
        InputViewWithError(input: $name,
                           inputView: textField,
                           isInputCorrect: isNameCorrect,
                           title: "Name:",
                           errorText: "Please type child name!")
    }
    
    private var textField: some View {
        TextField(placeholder, text: $name.unwrapped(defaultValue: ""))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .textContentType(.name)
            .autocapitalization(.words)
    }
}
