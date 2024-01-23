//
//  Storage.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import Foundation

protocol Storage {
    func store(child: Child)
    func retrieveChild() -> Child?
    func clearAll()
}


