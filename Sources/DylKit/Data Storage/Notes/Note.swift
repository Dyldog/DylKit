//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import Foundation

public struct Note: Hashable, Equatable {
    public let path: String
    public let title: String
    public let contents: String
}

extension Note: Identifiable {
    public var id: String { path }
}
