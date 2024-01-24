//
//  InputView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 24.01.2024.
//

import SwiftUI

struct InputView: View {
    @Binding var name: String?
    @Binding var birthday: Date?
    @Binding var portrait: UIImage?
    @Binding var isPhotoPickerPresented: Bool
    
    var isChildInfoIsFullFiled: Bool
    
    var clearAll: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            NameInputView(name: $name,
                          placeholder: "Type child name",
                          isNameCorrect: true)
            
            DateInputView(date: $birthday)
            
            OrangeButton(text: "Change portrait") {
                isPhotoPickerPresented = true
            }
            
            if isChildInfoIsFullFiled {
                OrangeButton(text: "Clear All") {
                    clearAll()
                }
            }
        }
    }
}
