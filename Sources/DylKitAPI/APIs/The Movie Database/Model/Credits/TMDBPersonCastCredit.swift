//
//  MovieCastCredit.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public struct TMDBPersonCastCredit: Decodable, TMDBPersonCreditType, Hashable {
    public let id: Int
    public let title: String
    public let character: String
    public let overview: String
    public let release_date: String
    public var poster_path: String?
    public var genre_ids: [Int]
    
    public var role: String { character }
}
