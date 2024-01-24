//
//  UserDefaultsStorage.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import Foundation

class UserDefaultStorage: Storage {
    private let childKey = "child_key"
    private let userDefaults = UserDefaults.standard

    init() { }

    func store(child: Child) {
        do {
            let data = try JSONEncoder().encode(child)
            userDefaults.set(data, forKey: childKey)
        } catch {
            // Handle encoding error
            print("Error encoding child: \(error)")
        }
    }

    func retrieveChild() -> Child? {
        do {
            if let storedData = userDefaults.data(forKey: childKey) {
                let loadedChild = try JSONDecoder().decode(Child.self, from: storedData)
                return loadedChild
            }
        } catch {
            // Handle decoding error
            print("Error decoding child: \(error)")
        }

        return nil
    }

    func clearAll() {
        userDefaults.removeObject(forKey: childKey)
    }
}
