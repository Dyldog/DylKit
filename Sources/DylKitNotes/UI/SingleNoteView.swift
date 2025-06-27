//
//  NotesView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 22/6/2023.
//

import DylKit
import HighlightedTextEditor
import SwiftUI

enum MarkdownToken: String {
    case squareBracketLink
    case uncheckedTodo
    case checkedTodo
}

enum MarkdownSymbol {
    enum Todo: String {
        case checked = "- [x]"
        case unchecked = "- [ ]"
    }
}

extension HighlightedTextEditor {
    
    
    static let boldItalics = try! NSRegularExpression(pattern: "_[^_]+_", options: [])
    static let noteLinks = try! NSRegularExpression(pattern: "\\[\\[[^\\[\\]]+\\]\\]", options: [])
    static let uncheckedTodo = try! NSRegularExpression(pattern: "\\s*- \\[ \\]", options: [])
    static let checkedTodo = try! NSRegularExpression(pattern: "\\s*- \\[x\\]", options: [])
    static let tagged = try! NSRegularExpression(pattern: "#\\w+", options: [])
    
    static let linkStyle = TextFormattingRule(fontTraits: [.traitItalic, .traitBold])
    
    static let rules = HighlightedTextEditor.markdown + [
        HighlightRule(pattern: noteLinks, formattingRules: [
            linkStyle,
            TextFormattingRule(key: .link, value: MarkdownToken.squareBracketLink.rawValue)
        ]),
        HighlightRule(pattern: uncheckedTodo, formattingRules: [
            linkStyle,
            TextFormattingRule(key: .link, value: MarkdownToken.uncheckedTodo.rawValue)
        ]),
        HighlightRule(pattern: checkedTodo, formattingRules: [
            linkStyle,
            TextFormattingRule(key: .link, value: MarkdownToken.checkedTodo.rawValue)
        ]),
        HighlightRule(pattern: tagged, formattingRules: [
            TextFormattingRule(key: .foregroundColor, value: UIColor.white),
            TextFormattingRule(key: .backgroundColor, value: UIColor.systemGreen)
        ])
    ]
}

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
    
    func clearNoteFolder() {
        notes.notesDirectoryURL = nil
    }
    
    mutating func didSelectLink(url: URL, text: String, at range: NSRange) {
        func replace(_ a: String, with b: String) {
            fileText = (fileText as NSString).replacingCharacters(
                in: range,
                with: text.replacingOccurrences(of: a, with: b)
            )
        }
        switch MarkdownToken(rawValue: url.absoluteString) {
        case .uncheckedTodo:
            replace(MarkdownSymbol.Todo.unchecked.rawValue, with: MarkdownSymbol.Todo.checked.rawValue)
        case .checkedTodo:
            replace(MarkdownSymbol.Todo.checked.rawValue, with: MarkdownSymbol.Todo.unchecked.rawValue)
        case .squareBracketLink, .none:
            break
        }
    }
}

public struct SingleNoteView: View {
    
    @State var viewModel: SingleNoteViewModel
    @State var showImporter: Bool = false
    @State var style: DisplayStyle = .markdown
    
    public init(viewModel: SingleNoteViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(viewModel.note.noteName)
                    .bold()
                
                Spacer()
                
                Picker("Style", selection: $style)
                    .pickerStyle(.menu)
                    .labelsHidden()
            }
            
            if viewModel.note.exists {
                switch style {
                case .markdown:
                    HighlightedTextEditor(
                        text: $viewModel.fileText,
                        highlightRules: HighlightedTextEditor.rules,
                        onLinkClick: { url, text, range in
                            if url.scheme != nil {
                                return true
                            } else {
                                viewModel.didSelectLink(url: url, text: text, at: range)
                                return false
                            }
                        }
                    )
                case .raw:
                    TextEditor(text: $viewModel.fileText)
                }

            } else {
                Button("Note doesn't exist. Create?") {
                    viewModel.createNote()
                }
                
                Button("Clear note folder?") {
                    viewModel.clearNoteFolder()
                }
                .foregroundStyle(.red)
            }
            
            Spacer()
        }
        .padding()
        .if(!viewModel.hasSelectedDirectory) {
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

extension SingleNoteView {
    enum DisplayStyle: Pickable, CaseIterable {
        case markdown
        case raw
        
        var title: String {
            switch self {
            case .markdown: "Markdown"
            case .raw: "Raw"
            }
        }
    }
}
