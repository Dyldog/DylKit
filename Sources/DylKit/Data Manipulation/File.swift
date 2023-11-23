//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/11/2023.
//

import Foundation

public extension Data {
    var string: String! { .init(data: self, encoding: .utf8) }
}
