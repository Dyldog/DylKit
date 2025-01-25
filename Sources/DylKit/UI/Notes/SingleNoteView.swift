//
//  NotesView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 22/6/2023.
//

import SwiftUI

public struct SingleNoteViewModel {
    private let notes: NotesDatabase = .init()
    var note: NoteAccessor { didSet { loadText() } }
    var hasSelectedDirectory: Bool { notes.hasSelectedDirectory }
    
    var fileText: String = "Note folder not selected yet" {
        didSet {
            writeNote()
        }
    }
    
    public init(noteName: String) {
        self.note = .init(noteName: noteName)
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

public struct SingleNoteView: View {
    
    @State var viewModel: SingleNoteViewModel
    @State var showImporter: Bool = false
    
    public init(viewModel: SingleNoteViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(viewModel.note.noteName)
                .bold()
            
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
