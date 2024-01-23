//
//  Child.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import UIKit

struct Child: Codable, Equatable {
    let name: String
    let birthday: Date
    private let imageData: Data?

    var image: UIImage? {
        if let imageData = imageData {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    init(name: String, birthday: Date, image: UIImage?) {
        self.name = name
        self.birthday = birthday
        self.imageData = image?.pngData()
    }
}
