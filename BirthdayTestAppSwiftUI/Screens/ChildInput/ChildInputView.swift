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
    
    @State private var isDatePickerVisible = false
    @State private var isPhotoPickerPresented = false
    @State private var navigateToBirthdayScreen = false
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    Image(uiImage: viewModel.portrait ??  ThemeManager.shared.theme.fullPortraitPlaceholderImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)
                        .clipShape(Circle())
                    
                    Spacer()
                        .frame(height: 40)
                    
                    InputView(name: $viewModel.name,
                              birthday: $viewModel.birthday,
                              portrait: $viewModel.portrait,
                              isPhotoPickerPresented: $isPhotoPickerPresented,
                              isChildInfoIsFullFiled: viewModel.isChildInfoIsFullFiled,
                              clearAll: {
                        viewModel.clearAll()
                    })
                    .showPhotosPicker(isPresented: $isPhotoPickerPresented,
                                      maxSelectionCount: 1) { image in
                        viewModel.portrait = image
                    }
                    
                    Spacer()
                    
                    OrangeButton(text: "Show birthday screen", disabled: !viewModel.isChildInfoIsFullFiled) {
                        navigateToBirthdayScreen = true
                    }
                }
                .padding(.horizontal, 30)
                .background(Color(ThemeManager.shared.theme.light))
                .navigationTitle("nanit")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(isPresented: $navigateToBirthdayScreen) {
                    BirthdayView(viewModel: .init(storage: viewModel.storage)) { portrait in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            viewModel.portrait = portrait
                        }
                        
                    }
                }
            }
            .onAppear {
                viewModel.refresh()
            }
        }
    }
    
    var dateBinding: Binding<String> {
        Binding {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: viewModel.birthday ?? Date())
        } set: { newValue in
        }
    }
}

#Preview {
    ChildInputView(viewModel: .init(storage: UserDefaultStorage()))
}
