//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import Foundation

public extension String {
    func replacingWholeMatch(_ string: String, with replacement: String) -> String {
        if self == string {
            return replacement
        } else {
            return self
        }
    }
}
