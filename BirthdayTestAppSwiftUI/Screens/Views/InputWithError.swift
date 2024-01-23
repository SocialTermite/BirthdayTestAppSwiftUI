//
//  InputWithError.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

struct InputViewWithError<InputType: Equatable, InputViewType: View>: View {
    
    @Binding var input: InputType?
    var inputView: InputViewType
    var isInputCorrect: Bool
    
    var title: String
    var errorText: String = ""
    
    @State private var isNameErrorShowing: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(Color("MainText"))
            
            inputView
                .onSubmit {
                    isNameErrorShowing = !isInputCorrect
                }
                .onChange(of: input) { oldValue, _ in
                    guard oldValue != nil else { return }
                    isNameErrorShowing = !isInputCorrect
                }
            
            if isNameErrorShowing {
                Text(errorText)
                    .font(.system(size: 15))
                    .foregroundStyle(.red)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color("MainText"))
            }
        }
    }
}
