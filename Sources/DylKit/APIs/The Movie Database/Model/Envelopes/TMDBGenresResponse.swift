//
//  TMDBGenresResponse.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public struct TMDBGenresResponse: Decodable {
    public let genres: [TMDBGenre]
}
