//
//  File.swift
//  
//
//  Created by Dylan Elliott on 31/1/2025.
//

import Foundation

public protocol TMDBResultType {
    var title: String { get }
    var poster_path: String? { get }
}

public extension TMDBResultType {
    var posterURL: URL? {
        poster_path.map { TMDBAPI.image(String($0)).url }
    }
}
