//
//  TMDBPagedResponse.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public struct TMDBPagedResponse<T: Decodable>: Decodable {
    public let results: [T]
}
