//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public protocol Loadable {
    associatedtype Loaded
    
//    @discardableResult
//    func retrieve(completion: @escaping  BlockIn<Result<Loaded, APIError>>) async /*-> URLSessionDataTask*/
    func retrieve() async throws -> Loaded
}

public protocol TypedAPI: API {
    associatedtype DataType
//    @discardableResult
//    func retrieve(completion: @escaping  BlockIn<Result<DataType, APIError>>) async /*-> URLSessionDataTask*/
    func retrieve() async throws -> DataType
}

//extension TypedAPI {
//    func retrive(completion: @escaping  BlockIn<Result<DataType, APIError>>) /*-> URLSessionDataTask*/ {
//        self.retrieve(completion: completion)
//    }
//}
