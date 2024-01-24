//
//  BirthdayViewModel.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 24.01.2024.
//

import SwiftUI

class BirthdayViewModel: ObservableObject {
    private let storage: Storage
    
    private lazy var child: Child = storage.retrieveChild() ?? .init(name: "ERROR", birthday: .now, image: nil) {
        didSet {
            guard child != oldValue else { return }
            storage.store(child: child)
        }
    }
    
    @Published var portrait: UIImage? {
        didSet {
            guard portrait != oldValue else {
                return
            }
            
            child = .init(name: child.name, birthday: child.birthday, image: portrait)
        }
    }
    
    var name: String {
        child.name
    }
    
    var numberImage: UIImage {
        numberImage(number: number)
    }
    
    private(set) var number: Int = 0
    private(set) var dateRepresentation: String = ""
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func refresh() {
        if let child = storage.retrieveChild() {
            self.child = child
        } else {
            self.child = .init(name: "Cristiano Ronaldo", birthday: Date(), image: nil)
        }
        self.portrait = child.image
        self.updateDateRepresentation()
    }
    
    var title: String {
        return ("Today".localized + " \(child.name) " + "is".localized).uppercased()
    }
    
    private func updateDateRepresentation() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let difference = calendar.dateComponents([.year, .month], from: child.birthday, to: currentDate)
        if let years = difference.year, let months = difference.month {
            if years > 0 {
                number = years
                dateRepresentation = "\(years == 1 ? "year".localized : "years".localized) old!".uppercased()
            } else if months >= 0 {
                number = months
                dateRepresentation = "\(months <= 1 ? "month".localized : "months".localized) old!".uppercased()
            }
        }
    }
    
    private func numberImage(number: Int) -> UIImage {
        let map: [Int: UIImage] = [
            0: ._0,
            1: ._1,
            2: ._2,
            3: ._3,
            4: ._4,
            5: ._5,
            6: ._6,
            7: ._7,
            8: ._8,
            9: ._9,
            10: ._10,
            11: ._11,
            12: ._12,
        ]
        return map[number] ?? ._0
    }
    
}
