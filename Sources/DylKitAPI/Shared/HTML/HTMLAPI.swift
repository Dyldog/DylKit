//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation
import SwiftSoup

public struct HTMLAPI<Input: LoadableInput, HTMLData: HTMLDataType>: TypedAPI {
    public let baseURL: URL
    public let defaultParameters: [String : String] = [:]
    
    public init(baseURL: URL, path: String, parameters: [String : String] = [:]) {
        self.baseURL = baseURL
        self.makePath = {_ in path}
        self.makeParameters = { _ in parameters}
    }
    
    public init(
        baseURL: URL, path: @escaping (Input) -> String, parameters: @escaping (Input) -> [String : String] = { _ in [:] }) {
        self.baseURL = baseURL
        self.makePath = path
        self.makeParameters = parameters
    }
    
    private let makePath: (Input) -> String
    
    public func path(with input: Input) -> String {
        makePath(input)
    }
    
    private let makeParameters: (Input) -> APIInput
    
    public func parameters(with input: Input) -> [String : String] {
        makeParameters(input)
    }
}

public extension HTMLAPI {
    func retrieve(_ input: Input) async throws -> HTMLData {
        let data: Data = try await retrieve(input)
        
        guard let html = String(data: data, encoding: .utf8) else { throw APIError.dataNotString }
        let document: Document
        do {
            document = try SwiftSoup.parse(html)
            return try HTMLData.mapper(document)
        } catch {
            throw APIError.decoding(error)
        }
    }
}
