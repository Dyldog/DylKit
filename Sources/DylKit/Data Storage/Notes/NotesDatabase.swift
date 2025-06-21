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
            else {
                notesDirectoryBookmark = nil
                return
            }
            
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
        
        let output = work(notesDirectoryURL.path.appending(path.withPrefix("/")))
        
        notesDirectoryURL.stopAccessingSecurityScopedResource()
        
        return output
    }
    
    public func noteExists(atPath path: String) -> Bool {
        return accessNotes(at: path) { url in
            return manager.fileExists(atPath: url)
        } ?? false
    }
    
    public func getNotes(in folder: String, filetypes: [String] = ["md"]) -> [Note]? {
        return accessNotes(at: folder) { url in
            guard let files = try? manager.contentsOfDirectory(atPath: url)
            else { return nil }
            
            return files
                .filter {
                    guard let filetype = $0.components(separatedBy: ".").last else { return false }
                    return filetypes.contains(filetype.lowercased())
                }
                .compactMap { getNote($0) }
        }
    }
    
    public func getFile(_ file: String) -> (String, Data?)? {
        return accessNotes(at: file) { url in
            return (url, manager.contents(atPath: url))
        }
    }
    
    public func getNote(_ file: String) -> Note? {
        guard
            let (url, data) = getFile(file), let data,
            let contents = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return .init(
            path: url.replacingOccurrences(of: notesDirectoryURL?.path ?? "", with: ""),
            title: file.fileTitle.trimmingCharacters(in: .init(["/"])),
            contents: contents
        )
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
