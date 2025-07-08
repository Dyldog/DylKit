//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import DylKit
import Foundation

public struct MappedAPI<Input: LoadableInput, MappedData>: Loadable {
    public typealias Loaded = MappedData
    public typealias Input = Input
    var retrieve: (Input) async throws -> MappedData
    
    init<API: Loadable>(api: API, mapper: @escaping BlockInOut<API.Loaded, MappedData>) where API.Input == Input {
        self.retrieve = { input in
            return mapper(try await api.retrieve(input))
        }
    }
    
    public func retrieve(_ input: Input) async throws -> MappedData {
        try await retrieve(input)
    }
}

extension Loadable {
    public func mapped<MappedOut>(_ mapper: @escaping BlockInOut<Loaded, MappedOut>) -> MappedAPI<Input, MappedOut> {
        .init(api: self, mapper: mapper)
    }
}

