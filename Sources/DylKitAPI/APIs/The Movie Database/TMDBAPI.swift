//
//  TMDB.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public enum TMDBAPI: API {
    public typealias Input = EmptyInput
    public typealias Loaded = Data
    
    public static var baseURL: URL {
        .init(string: "https://api.themoviedb.org/3")!
    }
    
    public var baseURL: URL {
        switch self {
        case .image: return .init(string: "https://image.tmdb.org/t/p/w500/")!
        default: return Self.baseURL
        }
    }
    
    public static var defaultParameters: [String: String] { ["api_key": Secrets.TMDB.apiKey] }
    public var defaultParameters: [String: String] { Self.defaultParameters }
    
    case searchPeople(String)
    case getCredits(Int)
    case movieCredits(Int)
    case image(String)
    case genres
    case findByIMDBID(String)
    
    public func path(with input: EmptyInput) -> String {
        switch self {
        case .searchPeople: return "/search/person"
        case .getCredits(let id): return "/person/\(id)/movie_credits"
        case .movieCredits(let id): return "/movie/\(id)/credits"
        case .image(let path): return path.withPrefix("/")
        case .genres: return "/genre/movie/list"
        case .findByIMDBID(let id): return "/find/\(id)"
        }
    }
    
    public func parameters(with input: EmptyInput) -> [String : String] {
        switch self {
        case .searchPeople(let query): return ["query": query]
        case .getCredits: return [:]
        case .movieCredits: return [:]
        case .image: return [:]
        case .genres: return [:]
        case .findByIMDBID: return ["external_source": "imdb_id"]
        }
    }
    
    public func retrieve(_ input: EmptyInput) async throws -> Data {
        fatalError()
    }
}

public enum TMDBJSONAPI {
    
    public struct SearchInput: LoadableInput {
        let query: String
        
        public init(_ query: String) {
            self.query = query
        }
    }
    
    public static let searchPeople: MappedAPI<SearchInput, [TMDBMoviePerson]> = JSONAPI(
        baseURL: .init(string: "https://api.themoviedb.org/3")!,
        path: { _ in "/search/person" }) { input in
            ["query": input.query].merging(TMDBAPI.defaultParameters) { lhs, _ in lhs }
        } .mapped { (response: TMDBPagedResponse<TMDBMoviePerson>) in
            response.results
        }
    
    public struct GetCreditsInput: LoadableInput {
        let actorID: Int
        
        public init(actorID: Int) {
            self.actorID = actorID
        }
    }
    
    public static let getCredits: MappedAPI<GetCreditsInput, [TMDBPersonCastCredit]> = JSONAPI(
        baseURL: TMDBAPI.baseURL,
        path: { TMDBAPI.getCredits($0.actorID).path(with: .init()) },
        parameters: { _ in TMDBAPI.defaultParameters }
    ).mapped { (response: TMDBPersonCredits) in
        response.cast
    }
    
    public struct GetMovieInput: LoadableInput {
        let movieID: Int
        
        public init(movieID: Int) {
            self.movieID = movieID
        }
    }
    
    public static let getMovie: JSONAPI<GetMovieInput, TMDBMovieDetail> = JSONAPI(
        baseURL: TMDBAPI.baseURL,
        path: { "/movie/\($0.movieID)" },
        parameters: { _ in TMDBAPI.defaultParameters }
    )
    
    public struct GetMovieCreditsInput: LoadableInput {
        let movieID: Int
        
        public init(movieID: Int) {
            self.movieID = movieID
        }
    }
    
    public static let getMovieCredits: JSONAPI<GetMovieCreditsInput, TMDBMovieCredits> = JSONAPI(
        baseURL: TMDBAPI.baseURL,
        path: { "/movie/\($0.movieID)/credits" },
        parameters: { _ in TMDBAPI.defaultParameters }
    )
    
    public static let getGenres: JSONAPI<EmptyInput, TMDBGenresResponse> = JSONAPI(
        baseURL: TMDBAPI.baseURL,
        path: "/genre/movie/list",
        parameters: TMDBAPI.defaultParameters
    )
}
