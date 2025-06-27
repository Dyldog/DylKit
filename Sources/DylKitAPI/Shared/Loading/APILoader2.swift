//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import SwiftUI

@MainActor
public class APILoader2<A: Loadable>: ObservableObject {
    public let api: A
    
    @Published public private(set) var loadedValue: Result<A.Loaded, APIError>?
    
    public init(api: A) {
        self.api = api
    }
    
    public func load() {
        Task {
            do {
                self.loadedValue = .success(try await api.retrieve())
            } catch let error as APIError {
                self.loadedValue = .failure(error)
            } catch {
                self.loadedValue = .failure(.unknown(error))
            }
        }
    }
}
