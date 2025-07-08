//
//  API.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public protocol API: Loadable {
    var baseURL: URL { get }
    var defaultParameters: [String: String] { get }
    
    func path(with input: Input) -> String
    func parameters(with input: Input) -> [String: String]
}

public extension API {
    typealias APIInput = [String: String]
    
    private func allParameters(with input: Input) -> [String: String] {
        defaultParameters.merging(parameters(with: input), uniquingKeysWith: { a, b in b })
    }
    
    func url(with input: Input) -> URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.path = baseURL.path + path(with: input) // the `URLComponents` is dropping the baseURL path
        components.queryItems = allParameters(with: input).map {
            .init(name: $0.key, value: $0.value)
        }
        return components.url!
    }
    
    func request(with input: Input) -> URLRequest {
        let request = URLRequest(url: url(with: input))
        return request
    }
}

public extension API where Input == EmptyInput {
    var path: String { path(with: EmptyInput()) }
    var parameters: [String: String] { parameters(with: EmptyInput()) }
    var url: URL { url(with: EmptyInput()) }
}

public extension API {
    func retrieve(_ input: Input) async throws -> Data {
        let task: (data: Data, response: URLResponse)
        let taskError: Error?
        
        do {
            let task: (data: Data, response: URLResponse) = await try URLSession.shared.data(
                for: request(with: input))
            return task.data
        } catch {
            throw APIError.general
        }
    }
}
