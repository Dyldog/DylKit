//
//  File.swift
//  
//
//  Created by Dylan Elliott on 16/12/2023.
//

#if canImport(UIKit)
import UIKit
#else
import AppKit
#endif

protocol Thenable { }

extension Thenable {
    func then(_ work: (Self) -> Void) -> Self {
        var value = self
        work(value)
        return value
    }
}

#if canImport(UIKit)
extension UIView: Thenable { }
#endif
