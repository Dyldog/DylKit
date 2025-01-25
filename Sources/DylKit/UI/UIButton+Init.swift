//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import UIKit

public extension UIButton {
    convenience init(title: String, action: @escaping () -> Void) {
        self.init(primaryAction: .init(handler: { _ in
            action()
        }))
        self.setTitle(title, for: .normal)
    }
    
    convenience init(icon: String, action: @escaping () -> Void) {
        self.init(primaryAction: .init(handler: { _ in
            action()
        }))
        self.setImage(.init(systemName: icon), for: .normal)
    }
}
