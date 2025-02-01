//
//  File.swift
//  
//
//  Created by Dylan Elliott on 31/1/2025.
//

import Foundation

public struct TMDBFindResponse: Codable {
    public let movie_results: [TMDBMovieResult]
    public let tv_results: [TMDBShowResult]
    
    public var firstMovie: TMDBResultType? { movie_results.first ?? tv_results.first }
}
