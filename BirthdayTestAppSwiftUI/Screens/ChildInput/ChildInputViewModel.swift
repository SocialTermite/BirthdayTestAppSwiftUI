//
//  ChildInputViewModel.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import SwiftUI
import UIKit

class ChildInputViewModel: ObservableObject {
    @Published var name: String?
    
    @Published var birthday: Date?
    
    @Published var portrait: UIImage?
    
    var isChildInfoIsFullFiled: Bool {
         return isNameCorrect && (birthday != nil)
     }
     
     var isNameCorrect: Bool {
         return (name != nil) && !(name?.isEmpty ?? true)
     }
}
