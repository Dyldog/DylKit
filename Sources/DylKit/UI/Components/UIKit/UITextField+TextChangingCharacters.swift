//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

#if canImport(UIKit)

import UIKit

public extension UITextField {
    func textByChangingCharactersInRange(range: NSRange, replacementString string: String) -> String {
        ((text ?? "") as NSString).replacingCharacters(in: range, with: string)
    }
}

#endif
