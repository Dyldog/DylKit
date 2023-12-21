//
//  File.swift
//  
//
//  Created by Dylan Elliott on 10/12/2023.
//

import Foundation

extension Encodable {
    public func encoded() -> Data { try! JSONEncoder().encode(self) }
}

extension Array where Element: Encodable {
    public func encoded() -> Data { try! JSONEncoder().encode(self) }
}
