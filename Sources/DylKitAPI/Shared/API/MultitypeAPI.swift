//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol MultitypeAPIData {
    static var empty: Self { get }
    func append(contentsOf: Self) -> Self
}

public struct MultitypeAPI<Input: LoadableInput, MappedData: MultitypeAPIData>: Loadable {
    let apis: [MappedAPI<Input, MappedData>]
    
    public init(apis: [MappedAPI<Input, MappedData>]) {
        self.apis = apis
    }
    
    public func retrieve(_ input: Input) async throws -> MappedData {
        
        var mapped: MappedData = .empty
        
        for api in apis {
            mapped.append(contentsOf: try await api.retrieve(input))
        }
        
        return mapped
    }
}
