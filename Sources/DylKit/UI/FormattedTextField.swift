//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

#if canImport(UIKit)
import UIKit

public class FormattedTextField<T: Equatable>: UITextField, UITextFieldDelegate {
    var value: T
    let formatter: (String) -> T?
    
    private let onUpdate: (T) -> Void
        
    public init(value: T, formatter: @escaping (String) -> T?, onUpdate: @escaping (T) -> Void) {
        self.value = value
        self.formatter = formatter
        self.onUpdate = onUpdate
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(formatText), for: .editingChanged)
        updateText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func formatText() {
        if let value = formatter(text ?? ""), self.value != value {
            self.value = value
            onUpdate(value)
        }
    }
    
    private func updateText() {
        text = "\(value)"
    }
}

extension UITextField {
    func nsRange(for textRange: UITextRange) -> NSRange {
        let location = offset(from: beginningOfDocument, to: textRange.start)
        let length = offset(from: textRange.start, to: textRange.end)
        return NSRange(location: location, length: length)
    }
}

#endif
