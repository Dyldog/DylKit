//
//  MoviePerson.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public struct TMDBMoviePerson: Decodable {
    public let id: Int
    public let name: String
    public let profile_path: String?
}

public extension TMDBMoviePerson {
    var imageURL: URL? {
        profile_path.map { TMDBAPI.image(String($0)).url }
    }
}
