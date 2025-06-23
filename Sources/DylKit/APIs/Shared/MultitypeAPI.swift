//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public typealias MappedAPI<API: TypedAPI, Mapped> = (api: API, mapper: BlockInOut<API.DataType, [Mapped]>)

public struct AnyMappedAPI<MultiData> {
    var retrieve: () async throws -> [MultiData]
    
    init<API: TypedAPI>(api: API, mapper: @escaping BlockInOut<API.DataType, [MultiData]>) {
        self.retrieve = {
            return mapper(try await api.retrieve())
        }
    }
}

extension TypedAPI {
    public func any<MultiData>(_ mapper: @escaping BlockInOut<DataType, [MultiData]>) -> AnyMappedAPI<MultiData> {
        .init(api: self, mapper: mapper)
    }
}
public struct MultitypeAPI<MultiData>: Loadable {
    let apis: [AnyMappedAPI<MultiData>]
    
    public init(apis: [AnyMappedAPI<MultiData>]) {
        self.apis = apis
    }
    
//    @discardableResult
    public func retrieve(
//        completion: @escaping BlockIn<Result<[MultiData], APIError>>
    ) async throws -> [MultiData] {
        
        var mapped: [MultiData] = []
        
        for api in apis {
            mapped.append(contentsOf: try await api.retrieve())
        }
        
        return mapped
    }
}
