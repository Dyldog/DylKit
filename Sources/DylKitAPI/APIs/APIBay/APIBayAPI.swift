//
//  File.swift
//  
//
//  Created by Dylan Elliott on 4/7/2025.
//

import Foundation

public struct APIBayResult: Codable {
    public let name: String
    public let seeders: String
    public let size: String
    public let info_hash: String
    
    public var seedersInt: Int { seeders.intValue ?? -1}
    public var sizeInt: Int { size.intValue ?? -1}
    
    public var magnetLink: URL {
        .init(string: "magnet:?xt=urn:btih:\(info_hash)")!
    }
}

public enum APIBayAPI {
    public struct SearchInput: LoadableInput {
        let query: String
        
        public init(query: String) {
            self.query = query
        }
    }
    
    public static let search: JSONAPI<SearchInput, [APIBayResult]> = JSONAPI(
        baseURL: .init(string: "https://apibay.org")!,
        path: { _ in "/q.php" },
        parameters: {
            ["q": $0.query]
        }
    )
}
