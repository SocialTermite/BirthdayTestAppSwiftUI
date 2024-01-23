//
//  ChildInputViewModel.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI
import UIKit

class ChildInputViewModel: ObservableObject {
    private let storage: Storage

    @Published var name: String? {
        didSet {
            guard name != oldValue else { return }
            tryToStoreChild()
        }
    }
    
    @Published var birthday: Date? {
        didSet {
            guard birthday != oldValue else { return }
            tryToStoreChild()
        }
    }
    
    @Published var portrait: UIImage? {
        didSet { tryToStoreChild() }
    }
    
    private var child: Child? {
        didSet {
            guard let child, child != oldValue else { return }
            storage.store(child: child)
        }
    }
    
    private func tryToStoreChild() {
        guard let name, let birthday else {
            return
        }
        
        child = .init(name: name, birthday: birthday, image: portrait)
    }
    
    var isChildInfoIsFullFiled: Bool {
        return isNameCorrect && (birthday != nil)
    }
    
    var isNameCorrect: Bool {
        return (name != nil) && !(name?.isEmpty ?? true)
    }
        
    init(storage: Storage) {
        self.storage = storage
    }
    
    func clearAll() {
        name = nil
        birthday = nil
        portrait = nil
        storage.clearAll()
        child = nil
    }
}
