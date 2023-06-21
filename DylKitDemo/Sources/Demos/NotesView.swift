//
//  NotesView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 22/6/2023.
//

import SwiftUI
import DylKit

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
struct NotesViewModel {
    private let notes: NotesDatabase = .init()
    var note: NoteAccessor = .init(noteName: "bezzle") { didSet { loadText() } }
    
    var hasSelectedDirectory: Bool { notes.hasSelectedDirectory }
    
    var fileText: String = "Note folder not selected yet" {
        didSet {
            writeNote()
        }
    }
    
    mutating func onAppear() {
        if note.exists {
            loadText()
        }
    }
    
    mutating private func loadText() {
        if let text = note.text {
            fileText = text
        }
    }
    
    mutating func didSelectNotesFolder(_ url: URL) {
        notes.notesDirectoryURL = url
        loadText()
    }
    
    mutating func createNote() {
        note.create(with: "\(Date.now.description)")
        loadText()
    }
    
    func writeNote() {
        note.write(fileText)
    }
}

struct NotesView: View {
    
    @State var viewModel: NotesViewModel = .init()
    @State var showImporter: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("File name", text: $viewModel.note.noteName)
            
            if viewModel.note.exists {
                TextEditor(text: $viewModel.fileText)
            } else {
                Button("Note doesn't exist. Create?") {
                    viewModel.createNote()
                }
            }
            
            Spacer()
        }
        .padding().if(!viewModel.hasSelectedDirectory) {
            $0.fileImporter(isPresented: $showImporter, allowedContentTypes: [.folder]) { result in
                showImporter = false
                
                switch result {
                case let .success(url): viewModel.didSelectNotesFolder(url)
                case .failure: break
                }
            }
        }.onAppear {
            viewModel.onAppear()
            showImporter = true
        }
    }
}
