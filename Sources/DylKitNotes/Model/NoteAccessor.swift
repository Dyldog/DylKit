//
//  File.swift
//  
//
//  Created by Dylan Elliott on 25/1/2025.
//

import Foundation

struct NoteAccessor {
    private let notes: NotesDatabase = .init()
    
    var noteName: String
    
    private var notePath: String { "/\(noteName).md" }
    
    var exists: Bool { notes.noteExists(atPath: notePath) }
    
    var text: String? { notes.getNote(notePath)?.contents }
    
    func create(with text: String) {
        notes.createNote(notePath, contents: text)
    }
    
    func write(_ content: String) {
        notes.writeNote(content, in: notePath)
    }
}
