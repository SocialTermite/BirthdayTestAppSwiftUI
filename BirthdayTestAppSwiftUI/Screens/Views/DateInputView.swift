//
//  DateInputView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

struct DateInputView: View {
    @Binding var date: Date?
    @State var mock: String = ""
    var body: some View {
        InputViewWithError(input: $date,
                           inputView: datePicker,
                           isInputCorrect: true,
                           title: "Birthday:"
        )
    }
    
    var datePicker: some View {
        TextField("Tap to input", text: $mock)
    }
}
