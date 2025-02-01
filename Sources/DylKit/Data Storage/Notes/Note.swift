//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import UIKit

public struct Note: Hashable, Equatable {
    public let path: String
    public let title: String
    public let contents: String
}

public extension Note {
    
    private var sanitisedTitle: String { title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! }
    private var noteURL: URL { .init(string: "obsidian://open?file=\(sanitisedTitle)")! }
    
    func open() {
        UIApplication.shared.open(noteURL)
    }
}

extension Note: Identifiable {
    public var id: String { path }
}
