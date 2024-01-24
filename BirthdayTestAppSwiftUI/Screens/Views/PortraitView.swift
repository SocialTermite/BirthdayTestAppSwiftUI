//
//  PortraitView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 24.01.2024.
//

import SwiftUI

struct PortraitView: View {
    
    @Binding var portrait: UIImage?
    
    var safeLayoutTopHeight: CGFloat {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let safeAreaInsets = windowScene.windows.first?.safeAreaInsets {
            return safeAreaInsets.top
        } else {
            return 0
        }
    }
    var body: some View {
        Circle()
            .stroke(Color(ThemeManager.shared.theme.dark), lineWidth: Constants.Numbers.portraitBorderWidth)
            .background(Circle().foregroundColor(Color(ThemeManager.shared.theme.light)))
            .overlay {
                ZStack {
                    if let portrait {
                        Image(uiImage: portrait)
                            .resizable()
                            .clipShape(Circle())
                            .padding(.all, 4)
                    } else {
                        GeometryReader { geometry in
                            let size = geometry.size.width / 1.5
                            Image(uiImage: ThemeManager.shared.theme.portraitPlaceholderImage)
                                .resizable()
                                .frame(width: size, height: size)
                                .offset(x: size / 4, y: size / 4)
                        }
                    }
                    
                    GeometryReader { geometry in
                        let frame = geometry.frame(in: .global)
                        let centerY = frame.minY + (frame.height / 2)
                        let delta = centerY - (UIScreen.main.bounds.height / 2)
                        
                        Image(uiImage:
                                ThemeManager.shared.theme.foregroundImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height - safeLayoutTopHeight)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2 - delta + safeLayoutTopHeight / 2)
                    }
                }
            }
    }
}
