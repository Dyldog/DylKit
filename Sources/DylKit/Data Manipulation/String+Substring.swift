//
//  File.swift
//  
//
//  Created by Dylan Elliott on 11/10/2023.
//

import Foundation

public extension String {
    func substring(with range: NSRange) -> String {
        return (self as NSString).substring(with: range)
    }
}
