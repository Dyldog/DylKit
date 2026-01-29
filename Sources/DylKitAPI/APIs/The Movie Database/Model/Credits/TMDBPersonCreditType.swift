//
//  MovieCreditType.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation
import SwiftUI

public protocol TMDBPersonCreditType {
    var id: Int { get }
    var title: String { get }
    var role: String { get}
    var overview: String { get }
    var release_date: String { get }
    var poster_path: String? { get }
    var genre_ids: [Int] { get }
}

extension TMDBPersonCreditType {
    var posterURL: URL? {
        poster_path.map { TMDBAPI.image(String($0)).url }
    }
}

extension TMDBPersonCreditType {
    var movie: TMDBMovie {
        .init(
            id: id,
            imageURL: posterURL ?? Image.placeholderURL,
            title: title,
            overview: overview,
            releaseDate: release_date,
            genreIDs: genre_ids
        )
    }
}

public extension Array where Element: TMDBPersonCreditType {
    var movies: [TMDBMovie] {
        map { $0.movie }
    }
}

public extension Array where Element: TMDBPersonCreditType {
    func credits(for movieID: Int) -> [String] {
        self.filter { $0.id == movieID }.map { $0.role }
    }
    
    func credits(for movie: TMDBMovie) -> [String] {
        credits(for: movie.id)
    }
}
