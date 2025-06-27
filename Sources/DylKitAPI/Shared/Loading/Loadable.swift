//
//  File.swift
//  
//
//  Created by Dylan Elliott on 23/6/2025.
//

import Foundation

public protocol Loadable {
    associatedtype Loaded
    func retrieve() async throws -> Loaded
}
