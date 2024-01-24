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
    var image: UIImage?
    var action: () -> Void


    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(text)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(disabled ? .secondary : .white)
                if let image {
                    Image(uiImage: image)
                }
            }

            
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 42)
        .background(Color.orangeLight)
        .cornerRadius(21)
        .disabled(disabled)
    }
}

#Preview {
    return OrangeButton(text: "Hello", action: {})
}
