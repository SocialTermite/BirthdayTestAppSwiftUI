//
//  ThemeManager.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import Foundation

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    private init() { }
    
    @Published var theme: Theme = randomTheme()
    
    func changeThemeRandomly() {
        theme = ThemeManager.randomTheme()
    }
    
    private static func randomTheme() -> Theme {
        .init(rawValue: Int.random(in: 0..<3)) ?? .blue
    }
}
