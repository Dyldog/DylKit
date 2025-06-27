//
//  TMDBMovie.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation


public struct TMDBMovie: Hashable, Codable {
    public let id: Int
    public let imageURL: URL
    public let title: String
    public let overview: String
    public let releaseDate: String
    public let genreIDs: [Int]
}
