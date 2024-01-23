//
//  BirthdayTestAppSwiftUIApp.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI

@main
struct BirthdayTestAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ChildInputView(viewModel: .init(storage: UserDefaultStorage()))
        }
    }
}


