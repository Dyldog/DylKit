//
//  String+Plural.swift
//  ThaiFlashCards
//
//  Created by Dylan Elliott on 18/9/2023.
//

import Foundation

public extension String {
    func pluralise(_ count: Int, pluralForm: String) -> String {
        return count == 1 ? self: pluralForm
    }
    
    func pluralise(_ count: Int, pluralSuffix: String) -> String {
        return pluralise(count, pluralForm: self + pluralSuffix)
    }
    
    func pluralise(_ count: Int) -> String {
        return pluralise(count, pluralSuffix: "s")
    }
}
