//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

#if canImport(UIKit)
import UIKit

public extension UITextField {
    func textAlignment(_ alignment: NSTextAlignment) -> UITextField {
        self.textAlignment = alignment
        return self
    }
    
    func delegate(_ delegate: UITextFieldDelegate) -> UITextField {
        self.delegate = delegate
        return self
    }
}

#endif
