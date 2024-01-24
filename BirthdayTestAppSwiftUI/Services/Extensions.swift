//
//  Extensions.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI
import PhotosUI


extension Binding {
    func unwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}


extension View {
    func showPhotosPicker(
        isPresented: Binding<Bool>,
        maxSelectionCount: Int,
        imageLoaded: @escaping ((UIImage) -> Void)
    ) -> some View {
        return self.photosPicker(
            isPresented: isPresented,
            selection: Binding<[PhotosPickerItem]>(
                get: { [] },
                set: { selectedPhotos in
                    Task {
                        if let selectedPhoto = selectedPhotos.first {
                            let loadedImage = await loadImage(from: selectedPhoto)
                            // Handle the loaded image as needed
                            // Update the Image binding if necessary
                            imageLoaded(loadedImage)
                        }
                    }
                }
            ),
            maxSelectionCount: maxSelectionCount,
            matching: .images
        )
    }

    private func loadImage(from photoItem: PhotosPickerItem) async -> UIImage {
        if let data = try? await photoItem.loadTransferable(type: Data.self),
           let image = UIImage(data: data) {
            return image
        }
        // Handle error or return a default image
        return UIImage() // Default image, change as needed
    }
}
