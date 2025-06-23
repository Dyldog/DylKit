//
//  TMDB.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public enum TMDBAPI: API {
    public var baseURL: URL {
        switch self {
        case .image: return .init(string: "https://image.tmdb.org/t/p/w500/")!
        default: return .init(string: "https://api.themoviedb.org/3")!
        }
    }
    
    public var defaultParameters: [String: String] { ["api_key": Secrets.TMDB.apiKey] }
    
    case searchPeople(String)
    case getCredits(Int)
    case movieCredits(Int)
    case image(String)
    case genres
    case findByIMDBID(String)
    
    public var path: String {
        switch self {
        case .searchPeople: return "/search/person"
        case .getCredits(let id): return "/person/\(id)/movie_credits"
        case .movieCredits(let id): return "/movie/\(id)/credits"
        case .image(let path): return path.withPrefix("/")
        case .genres: return "/genre/movie/list"
        case .findByIMDBID(let id): return "/find/\(id)"
        }
    }
    
    public var parameters: [String : String] {
        switch self {
        case .searchPeople(let query): return ["query": query]
        case .getCredits: return [:]
        case .movieCredits: return [:]
        case .image: return [:]
        case .genres: return [:]
        case .findByIMDBID: return ["external_source": "imdb_id"]
        }
    }
}
