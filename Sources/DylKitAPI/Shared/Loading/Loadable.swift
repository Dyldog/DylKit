//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import Foundation

public protocol LoadableInput {
}

//extension Dictionary: LoadableInput where Key == String, Value == String {
//    public func makeDict() -> [String : String] {
//        self
//    }
//}

public struct EmptyInput: LoadableInput {
//    public func makeDict() -> [String : String] {
//        [:]
//    }
    
    public init() { }
}
public protocol Loadable {
    associatedtype Loaded
    associatedtype Input: LoadableInput
    func retrieve(_ input: Input) async throws -> Loaded
}

extension Loadable where Input == EmptyInput {
    func retrieve() async throws -> Loaded {
        try await retrieve(EmptyInput())
    }
}
