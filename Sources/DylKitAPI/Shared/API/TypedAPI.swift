//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol TypedAPI: API {
    associatedtype DataType
    func retrieve(_ intput: Input) async throws -> DataType
}

extension TypedAPI where Input == EmptyInput {
    func retrieve() async throws -> DataType {
        try await retrieve(EmptyInput())
    }
}
