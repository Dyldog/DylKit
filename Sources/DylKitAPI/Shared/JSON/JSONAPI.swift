//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

//public protocol JSONAPI: TypedAPI { }
//
//public extension JSONAPI {
//    func retrieve<T: Decodable>(_ type: T.Type) async throws -> T {
//        let data: Data = try await retrieve()
//        do {
//            let value = try JSONDecoder().decode(T.self, from: data)
//            return value
//        } catch {
//            throw APIError.decoding(error)
//        }
//    }
//}
//

public struct JSONAPI<Input: LoadableInput, JSONData: Decodable>: TypedAPI {
    public let baseURL: URL
    public let defaultParameters: [String : String] = [:]
    
    private let makePath: (Input) -> String
    
    public func path(with input: Input) -> String {
        makePath(input)
    }
    
    private let makeParameters: (Input) -> APIInput
    
    public func parameters(with input: Input) -> [String : String] {
        makeParameters(input)
    }
    
    public init(baseURL: URL, path: String, parameters: [String : String] = [:]) {
        self.baseURL = baseURL
        self.makePath = { _ in path }
        self.makeParameters = {_ in parameters }
    }
    
    public init(baseURL: URL, path: @escaping (Input) -> String, parameters: @escaping (Input) -> APIInput = { _ in [:] }) {
        self.baseURL = baseURL
        self.makePath = path
        self.makeParameters = parameters
    }
}

public extension JSONAPI {
    func retrieve(_ input: Input) async throws -> JSONData {
        let data: Data = try await retrieve(input)
        try Task.checkCancellation()
        do {
            return try JSONDecoder().decode(JSONData.self, from: data)
        } catch {
            print(String(data: data, encoding: .utf8))
            throw error
        }
    }
}
