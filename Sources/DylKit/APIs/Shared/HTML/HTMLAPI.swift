//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation
import SwiftSoup

public struct HTMLAPI<HTMLData: HTMLDataType>: TypedAPI {
    public let baseURL: URL
    public let path: String
    public let parameters: [String : String]
    public let defaultParameters: [String : String] = [:]
    
    public init(baseURL: URL, path: String, parameters: [String : String] = [:]) {
        self.baseURL = baseURL
        self.path = path
        self.parameters = parameters
    }
}

public extension HTMLAPI {
//    @discardableResult
    func retrieve(
//        completion: @escaping  BlockIn<Result<HTMLData, APIError>>
    ) async throws -> HTMLData {
        let data: Data = try await retrieve()
        
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
