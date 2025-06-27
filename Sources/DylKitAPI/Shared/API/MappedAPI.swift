//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import DylKit
import Foundation

public struct MappedAPI<MappedData> {
    var retrieve: () async throws -> [MappedData]
    
    init<API: TypedAPI>(api: API, mapper: @escaping BlockInOut<API.DataType, [MappedData]>) {
        self.retrieve = {
            return mapper(try await api.retrieve())
        }
    }
}

extension TypedAPI {
    public func mapped<MappedData>(_ mapper: @escaping BlockInOut<DataType, [MappedData]>) -> MappedAPI<MappedData> {
        .init(api: self, mapper: mapper)
    }
}
