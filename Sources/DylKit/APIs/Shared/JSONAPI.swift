//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol JSONAPI: TypedAPI { }

public extension JSONAPI {
//    @discardableResult
    func retrieve<T: Decodable>(_ type: T.Type) async throws -> T {
        let data: Data = try await retrieve()
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            throw APIError.decoding(error)
        }
    }
}

