//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import UIKit

public extension UIStackView {
    static func horizontal(_ subviews: [UIView]) -> UIStackView {
        let stackview = UIStackView(arrangedSubviews: subviews)
        stackview.axis = .horizontal
        return stackview
    }
    
    static func vertical(_ subviews: [UIView]) -> UIStackView {
        let stackview = UIStackView(arrangedSubviews: subviews)
        stackview.axis = .vertical
        return stackview
    }
}
