//
//  BirthdayView.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

struct BirthdayView: View {
    @ObservedObject var viewModel: BirthdayViewModel
    var refresh: ((UIImage?) -> Void)?
    @Environment(\.presentationMode) var presentationMode
    @State private var isPhotoPickerPresented: Bool = false
    @State private var hideForScreenCapture = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    header
                    Spacer()
                    main
                    Spacer()
                }
                backButton
                    .opacity(hideForScreenCapture ? 0 : 1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(ThemeManager.shared.theme.light))
        }
        .onAppear {
            viewModel.refresh()
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var header: some View {
        Text(viewModel.title)
            .frame(maxWidth: 226)
            .multilineTextAlignment(.center)
            .font(.system(size: 21, weight: .medium))
            .padding(.bottom, 13)
            .padding(.top, 20)
        
        HStack(spacing: 22) {
            Image(.leftSwirls)
            Image(uiImage: viewModel.numberImage)
            Image(.rightSwirls)
        }
        Text(viewModel.dateRepresentation)
            .font(.system(size: 21, weight: .medium))
            .padding(.top, 14)
            .padding(.bottom, 20)
    }
    
    @ViewBuilder
    var main: some View {
        HStack() {
            Spacer(minLength: 50)
            VStack {
                ZStack {
                    PortraitView(portrait: $viewModel.portrait)
                    changePortraitButton
                        .opacity(hideForScreenCapture ? 0 : 1)
                    
                }
                
                Image(.logo)
                    .padding(.bottom, 22)
                    .padding(.top, 15)
                
                Spacer()
                    .frame(maxHeight: 45)
                
                OrangeButton(text: "Share the news", image: .shareIcon) {
                    print(takeScreenshot())
                }.frame(width: 179)
                    .opacity(hideForScreenCapture ? 0 : 1)
                
                
            }
            Spacer(minLength: 50)
        }
        .showPhotosPicker(isPresented: $isPhotoPickerPresented,
                          maxSelectionCount: 1) { image in
            viewModel.portrait = image
        }
    }
    
    func takeScreenshot() {
        hideForScreenCapture = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            
            let renderer = UIGraphicsImageRenderer(size: window.bounds.size)
            let image = renderer.image { context in
                window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
            }
            hideForScreenCapture = false
            
            let activityViewController = UIActivityViewController(
                activityItems: [image],
                applicationActivities: nil
            )
            
            windowScene.windows.first?.rootViewController?
                .present(activityViewController, animated: true, completion: nil)
        }
    }
    
    let smallSize: CGFloat = 36
    let angleOffset: Double = 0
    
    @ViewBuilder
    var changePortraitButton: some View {
        GeometryReader { proxy in
            let width: CGFloat = proxy.size.width
            let height: CGFloat = proxy.size.height
            
            let angleInRadians = CGFloat.pi * Constants.Numbers.changePortraitButtonPositionAngle / 180.0
            let radius = min(width, height) / 2
            
            let buttonCenterX = width / 2 + radius * cos(angleInRadians)
            let buttonCenterY = height / 2 - radius * sin(angleInRadians)
            
            let buttonSize: CGFloat = Constants.Numbers.changePortraitButtonSize
            
            Button {
                isPhotoPickerPresented = true
            } label: {
                Image(uiImage: ThemeManager.shared.theme.addImage)
                    .frame(width: buttonSize, height: buttonSize)
                    .position(x: buttonCenterX - buttonSize / 2,
                              y: buttonCenterY - buttonSize / 2)
            }
        }
    }
    
    @ViewBuilder
    var backButton: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                    refresh?(viewModel.portrait)
                }) {
                    Image(.backIcon)
                }
                Spacer() // Pushes the VStack to the right
            }
            Spacer()
        }
        .padding(.top, 13)
        .padding(.leading, 11)
    }
    
    func degreesToRadians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }
}

#Preview {
    BirthdayView(viewModel: .init(storage: UserDefaultStorage()))
}
