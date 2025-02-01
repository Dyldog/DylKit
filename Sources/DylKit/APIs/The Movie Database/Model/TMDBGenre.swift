//
//  MovieGenre.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public struct TMDBGenre: Decodable, Hashable, Identifiable {
    public let id: Int
    public let name: String
}
