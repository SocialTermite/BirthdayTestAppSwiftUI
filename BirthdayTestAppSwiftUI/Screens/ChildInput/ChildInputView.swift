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
    
    var dateBinding: Binding<String> {
        Binding {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return dateFormatter.string(from: viewModel.birthday ?? Date())
        } set: { newValue in
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(uiImage: viewModel.portrait ??  ThemeManager.shared.theme.fullPortraitPlaceholderImage)
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
                        isPhotoPickerPresented.toggle()
                    }
                    
                    if viewModel.isChildInfoIsFullFiled {
                        OrangeButton(text: "Clear All") {
                            viewModel.clearAll()
                        }
                    }
                }
                .photosPicker(
                    isPresented: $isPhotoPickerPresented,
                    selection: Binding<[PhotosPickerItem]>(
                        get: { [] },
                        set: { selectedPhotos in
                            if let selectedPhoto = selectedPhotos.first {
                                loadImage(from: selectedPhoto)
                            }
                        }
                    ),
                    maxSelectionCount: 1,
                    matching: .images
                )
                
                Spacer()
                
                OrangeButton(text: "Show birthday screen", disabled: !viewModel.isChildInfoIsFullFiled) {
                    
                }
            }.padding(.horizontal, 30)
        }
        .padding()
        .background(Color(ThemeManager.shared.theme.light))
    }
    
    private func loadImage(from photoItem: PhotosPickerItem) {
        photoItem.loadTransferable(type: Data.self) { result in
            switch result {
            case .success(let data):
                if let data = data,
                   let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        viewModel.portrait = image
                    }
                }
            case .failure(let error):
                print("Error loading image data: \(error)")
            }
        }
    }
}

#Preview {
    ChildInputView(viewModel: .init(storage: UserDefaultStorage()))
}
