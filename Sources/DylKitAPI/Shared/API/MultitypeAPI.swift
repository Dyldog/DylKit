//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public struct MultitypeAPI<MappedData>: Loadable {
    let apis: [MappedAPI<MappedData>]
    
    public init(apis: [MappedAPI<MappedData>]) {
        self.apis = apis
    }
    
    public func retrieve() async throws -> [MappedData] {
        
        var mapped: [MappedData] = []
        
        for api in apis {
            mapped.append(contentsOf: try await api.retrieve())
        }
        
        return mapped
    }
}
