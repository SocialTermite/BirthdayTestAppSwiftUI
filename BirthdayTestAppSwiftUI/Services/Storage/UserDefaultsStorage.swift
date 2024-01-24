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
    
    private var child: Child?
    
    init() { }

    func store(child: Child) {
        self.child = child
        do {
            let data = try JSONEncoder().encode(child)
            userDefaults.set(data, forKey: childKey)
            userDefaults.synchronize()
        } catch {
            // Handle encoding error
            print("Error encoding child: \(error)")
        }
    }

    func retrieveChild() -> Child? {
        if let child {
            return child
        }
        do {
            if let storedData = userDefaults.data(forKey: childKey) {
                let loadedChild = try JSONDecoder().decode(Child.self, from: storedData)
                self.child = loadedChild
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
        userDefaults.setNilValueForKey(childKey)
        userDefaults.synchronize()
        child = nil
    }
}
