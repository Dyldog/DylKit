//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import UIKit

public extension UILabel {
    convenience init(_ text: String) {
        self.init(frame: .zero)
        self.text = text
    }
}
