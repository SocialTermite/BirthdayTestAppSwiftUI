//
//  DatePickerTextField.swift
//  BirthdayTestAppSwiftUI
//
//  Created by Konstantin Bondar on 23.01.2024.
//

import UIKit
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    @Binding var selectedDate: Date?
    var placeHolder: String
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: DatePickerTextField
        var textField: UITextField?
        
        private var datePicker = UIDatePicker()
        
        init(parent: DatePickerTextField) {
            self.parent = parent
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.textField = textField
            
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.maximumDate = .now
            parent.selectedDate = datePicker.date
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
            toolbar.setItems([spaceButton, doneButton], animated: false)
            
            textField.inputView = datePicker
            textField.inputAccessoryView = toolbar
        }
        
        @objc func doneTapped() {
            parent.selectedDate = datePicker.date
            textField?.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.placeholder = placeHolder
        textField.delegate = context.coordinator
        textField.borderStyle = .roundedRect
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let date = selectedDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            uiView.text = dateFormatter.string(from: date)
        } else {
            uiView.text = ""
        }
    }
}
