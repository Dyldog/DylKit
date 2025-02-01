//
//  File.swift
//  
//
//  Created by Dylan Elliott on 31/1/2025.
//

import Foundation

public struct TMDBShowResult: Codable, TMDBResultType {
    public let id: Int
    public let name: String
    public var title: String { name }
    public let overview: String
    public let first_air_date: String
    public let poster_path: String?
    public let genre_ids: [Int]
}
