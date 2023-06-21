//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2023.
//

import Foundation

public class NotesDatabase {
    enum Defaults: String, DefaultsKey {
        case notesBookmark = "NOTES_BOOKMARK"
    }
    private let manager = FileManager()
    
    @UserDefaultable public var notesDirectoryBookmark: Data?
    
    public var notesDirectoryURL: URL? {
        get {
            notesDirectoryBookmark.map {
                var stale = false
                return try? URL(resolvingBookmarkData: $0, options: [.withoutUI], relativeTo: nil, bookmarkDataIsStale: &stale)
            }
        }
        set {
            guard
                let newValue = newValue,
                newValue.startAccessingSecurityScopedResource()
            else { return }
            
            notesDirectoryBookmark = try! newValue.bookmarkData(options: .suitableForBookmarkFile, includingResourceValuesForKeys: nil, relativeTo: nil)
            newValue.stopAccessingSecurityScopedResource()
        }
    }
    
    public var hasSelectedDirectory: Bool { notesDirectoryBookmark != nil }
    
    public init(notesDirectoryBookmark: Data? = nil) {
        _notesDirectoryBookmark = .init(wrappedValue: nil, key: Defaults.notesBookmark)
    }
    
    private func accessNotes<T>(at path: String, _ work: (String) -> T?) -> T? {
        guard
            let notesDirectoryURL = notesDirectoryURL, notesDirectoryURL.startAccessingSecurityScopedResource()
        else { return nil }
        
        let output = work(notesDirectoryURL.path.appending(path))
        
        notesDirectoryURL.stopAccessingSecurityScopedResource()
        
        return output
    }
    
    public func noteExists(atPath path: String) -> Bool {
        return accessNotes(at: path) { url in
            return manager.fileExists(atPath: url)
        } ?? false
    }
    
    public func getNote(_ file: String) -> Note? {
        return accessNotes(at: file) { url in
            guard
                let data = manager.contents(atPath: url),
                let contents = String(data: data, encoding: .utf8)
            else {
                return nil
            }
            
            return .init(
                path: url,
                title: file.replacingOccurrences(of: ".md", with: ""),
                contents: contents
            )
        }
    }
    
    public func createNote(_ file: String, contents: String) {
        _ = accessNotes(at: file) { url in
            manager.createFile(atPath: url, contents: contents.data(using: .utf8))
        }
    }
    
    public func writeNote(_ contents: String, in file: String) {
        accessNotes(at: file) { url in
            try! contents.write(toFile: url, atomically: true, encoding: .utf8)
        }
    }
}
