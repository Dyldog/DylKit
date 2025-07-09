//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol MultitypeAPIData {
    static var empty: Self { get }
    mutating func append(contentsOfAPIData other: Self)
}

extension Array: MultitypeAPIData {
    public static var empty: Array<Element> { [] }
    
    public mutating func append(contentsOfAPIData other: Array<Element>) {
        self.append(contentsOf: other)
    }
}

public struct MultitypeAPI<Input: LoadableInput, MappedData: MultitypeAPIData>: Loadable {
    let apis: [MappedAPI<Input, MappedData>]
    
    public init(apis: [MappedAPI<Input, MappedData>]) {
        self.apis = apis
    }
    
    public func retrieve(_ input: Input) async throws -> MappedData {
        
        var mapped: MappedData = .empty
        
        for api in apis {
            mapped.append(contentsOfAPIData: try await api.retrieve(input))
        }
        
        return mapped
    }
}
