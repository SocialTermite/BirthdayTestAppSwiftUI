//
//  ContentView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI
import PhotosUI

struct ChildInputView: View {
    @ObservedObject var viewModel: ChildInputViewModel

    var body: some View {
        VStack {
            VStack {
                Image(uiImage: ThemeManager.shared.theme.fullPortraitPlaceholderImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 160)
                    .clipShape(Circle())
                Spacer()
                    .frame(height: 40)
                VStack(spacing: 20) {
                    NameInputView(name: $viewModel.name,
                                  placeholder: "Type child name",
                                  isNameCorrect: true)
                    
                    DateInputView(date: $viewModel.birthday)
                    
                    OrangeButton(text: "Change portrait") {
                    }
                    
                    if viewModel.isChildInfoIsFullFiled {
                        OrangeButton(text: "Clear All") {
                        }
                    }
                }
                
                
                Spacer()
                
                OrangeButton(text: "Show birthday screen", disabled: !viewModel.isChildInfoIsFullFiled) {
                    
                }
            }.padding(.horizontal, 30)
        }
        .padding()
        .background(Color(ThemeManager.shared.theme.light))
        
    }
}

#Preview {
    ChildInputView(viewModel: .init())
}
