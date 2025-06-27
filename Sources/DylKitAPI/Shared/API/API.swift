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
    
    var path: String { get }
    var parameters: [String: String] { get }
}

public extension API {
    private var allParameters: [String: String] {
        defaultParameters.merging(parameters, uniquingKeysWith: { a, b in b })
    }
    
    var url: URL {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.path = baseURL.path + path // the `URLComponents` is dropping the baseURL path
        components.queryItems = allParameters.map {
            .init(name: $0.key, value: $0.value)
        }
        return components.url!
    }
    
    var request: URLRequest {
        let request = URLRequest(url: url)
        return request
    }
}

public extension API {
    func retrieve() async throws -> Data {
        let task: (data: Data, response: URLResponse)
        let taskError: Error?
        
        do {
            let task: (data: Data, response: URLResponse) = await try URLSession.shared.data(for: request)
            return task.data
        } catch {
            throw APIError.general
        }
    }
}
