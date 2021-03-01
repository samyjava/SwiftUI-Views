//
//  TextWithDone.swift
//
//  Created by Sam Javadizadeh on 2/7/21.
//

import SwiftUI

struct TextFieldWithDone: UIViewRepresentable {
    let placeholder: String
    var keyType: UIKeyboardType
    let autocapitalizationType: UITextAutocapitalizationType
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.keyboardType = keyType
        textField.delegate = context.coordinator
        textField.autocapitalizationType = autocapitalizationType
        textField.textColor = UIColor(ColorPalette.addIntHeader)
        let toolbar = UIToolbar()
        toolbar.items = [.flexibleSpace(),.init(barButtonSystemItem: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))]
        toolbar.sizeToFit()
        textField.inputAccessoryView = toolbar
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldWithDone
        
        init(_ parent: TextFieldWithDone) {
            self.parent = parent
        }
        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.text = textField.text ?? ""
            }
        }
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}


struct TextEditorWithDone: UIViewRepresentable {
    let placeholder: String
    var keyType: UIKeyboardType
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textField = UITextView()
        textField.text = placeholder
        textField.keyboardType = keyType
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.delegate = context.coordinator
        let toolbar = UIToolbar()
        toolbar.items = [.flexibleSpace(), .init(barButtonSystemItem: .done, target: self, action: #selector(textField.doneButtonTapped(button:)))]
        toolbar.sizeToFit()
        textField.textColor = UIColor(ColorPalette.placeholder)
        textField.inputAccessoryView = toolbar
        return textField
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextEditorWithDone
        
        init(_ parent: TextEditorWithDone) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.parent.text = textView.text ?? ""
            }
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == parent.placeholder {
                textView.text = ""
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text == "" {
                textView.text = parent.placeholder
            }
        }
        
    }
}

extension  UITextView{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }
}
