//
//  File.swift
//  
//
//  Created by Dylan Elliott on 31/1/2025.
//

import SwiftUI

struct NotesFolderSelector: ViewModifier {
    @State var selectorPresented: Bool = false
    let database: NotesDatabase
    let onSelect: () -> Void
    
    init(database: NotesDatabase = .init(), onSelect: @escaping () -> Void) {
        self.selectorPresented = false
        self.database = database
        self.onSelect = onSelect
    }
    
    func body(content: Content) -> some View {
        content.if(!database.hasSelectedDirectory) {
            $0.fileImporter(isPresented: $selectorPresented, allowedContentTypes: [.folder]) { result in
                selectorPresented = false
                
                switch result {
                case let .success(url): 
                    database.notesDirectoryURL = url
                    onSelect()
                case .failure:
                    break
                }
            }
        }.onAppear {
            selectorPresented = true
        }
    }
}

public extension View {
    func withNotesFolderSelector(in database: NotesDatabase = .init(), onSelect: @escaping () -> Void) -> some View {
        modifier(NotesFolderSelector(database: database, onSelect: onSelect))
    }
}
