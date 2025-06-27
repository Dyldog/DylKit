//
//  TMDBPersonCredits.swift
//  MovieCal
//
//  Created by Dylan Elliott on 20/10/2023.
//

import Foundation

public struct TMDBMovieCredits: Codable {
    public let cast: [TMDBMovieCastCredit]
    public let crew: [TMDBMovieCrewCredit]
}

public protocol TMDBMovieCreditType {
    var id: Int { get }
    var name: String { get }
    var profile_path: String? { get }
    var role: String { get }
    var popularity: Float { get }
}

public extension TMDBMovieCreditType {
    var imageURL: URL? {
        profile_path.map { TMDBAPI.image(String($0)).url }
    }
}

public struct TMDBMovieCastCredit: TMDBMovieCreditType, Codable {
    public let id: Int
    public let name: String
    public let profile_path: String?
    public let character: String
    public var role: String { character }
    public var popularity: Float
}

public struct TMDBMovieCrewCredit: TMDBMovieCreditType, Codable {
    public let id: Int
    public let name: String
    public let profile_path: String?
    public let department: String
    public let job: String
    public var role: String { "\(department): \(job)" }
    public var popularity: Float
}
