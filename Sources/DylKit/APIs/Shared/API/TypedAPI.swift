//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol TypedAPI: API {
    associatedtype DataType
    func retrieve() async throws -> DataType
}
