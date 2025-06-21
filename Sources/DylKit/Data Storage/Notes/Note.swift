//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import Foundation

#if canImport(UIKit)
import UIKit
#endif

public struct Note: Hashable, Equatable {
    public let path: String
    public let title: String
    public let contents: String
    
    public var filename: String {
        path.filename
    }
    
    public var fileExtension: String {
        path.fileExtension
    }
}

public extension Note {
    
    private var sanitisedTitle: String { title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! }
    private var noteURL: URL { .init(string: "obsidian://open?file=\(sanitisedTitle)")! }
    
    func open() {
        SharedApplication.openURL(noteURL)
    }
}

extension Note: Identifiable {
    public var id: String { path }
}
