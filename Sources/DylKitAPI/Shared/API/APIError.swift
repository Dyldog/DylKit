//
//  APIError.swift
//  MovieCal
//
//  Created by Dylan Elliott on 19/2/2023.
//

import Foundation

public enum APIError: Error, LocalizedError {
    case general
    case dataNotString
    case decoding(Error)
    case unknown(Error)
    
    public var errorDescription: String? {
        switch self {
        case .general: "General"
        case .dataNotString: "Data not string"
        case let .decoding(decodingError): "Decoding error: \(decodingError)"
        case let .unknown(unknownError): "Unknown: \(unknownError)"
        }
    }
}
