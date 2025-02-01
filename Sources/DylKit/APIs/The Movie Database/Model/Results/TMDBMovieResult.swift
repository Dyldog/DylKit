//
//  File.swift
//  
//
//  Created by Dylan Elliott on 31/1/2025.
//

import Foundation

public struct TMDBMovieResult: Codable, TMDBResultType {
    public let id: Int
    public let title: String
    public let overview: String
    public let release_date: String
    public let poster_path: String?
    public let genre_ids: [Int]
}
