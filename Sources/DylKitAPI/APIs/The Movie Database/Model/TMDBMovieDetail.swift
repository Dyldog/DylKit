//
//  File.swift
//  
//
//  Created by Dylan Elliott on 4/7/2025.
//

import DylKit
import Foundation

public struct TMDBMovieDetail: Codable, Hashable {
    public let title: String
    public let budget: Int
    public let overview: String
    public let release_date: String
    public let poster_path: String?
    
    public var imageURL: URL? {
        poster_path.map { TMDBAPI.image(String($0)).url }
    }
}
