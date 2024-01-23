//
//  OrangeButton.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

struct OrangeButton: View {
    var text: String
    var disabled: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(disabled ? .secondary : .white)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 42)
        .background(Color.orangeLight)
        .cornerRadius(21)
    }
}
