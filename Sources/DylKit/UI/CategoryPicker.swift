//
//  File.swift
//  
//
//  Created by Dylan Elliott on 30/12/2023.
//

import SwiftUI

public struct CategoryPickerItem<T> {
    public let id: String
    public let title: String
    public let image: Image?
    public let value: Value<T>
    
    public init(id: String, title: String, image: Image?, value: Value<T>) {
        self.id = id
        self.title = title
        self.image = image
        self.value = value
    }
    
    public indirect enum Value<S> {
        case children([CategoryPickerItem<S>])
        case value(S)
    }
}

extension Array {
    func unwrapSingleElements<S>() -> [CategoryPickerItem<S>] where Element == CategoryPickerItem<S> {
        if count == 1, let element = first {
            switch element.value {
            case let .children(children): return children.unwrapSingleElements()
            case .value: return self
            }
        } else {
            return self
        }
    }
    
    func categories<S>() -> [CategoryPickerItem<S>] where Element == CategoryPickerItem<S> {
        self.filter {
            switch $0.value {
            case .children: return true
            case .value: return false
            }
        }
    }
    
    func values<S>() -> [CategoryPickerItem<S>] where Element == CategoryPickerItem<S> {
        self.filter {
            switch $0.value {
            case .children: return false
            case .value: return true
            }
        }
    }
}

public struct CategoryPicker<T>: View {
    let title: String
    let isRoot: Bool
    let values: [CategoryPickerItem<T>]
    let categories: [CategoryPickerItem<T>]
    let onSelect: (T) -> Void
    @State var selectedElement: CategoryPickerItem<T>?
    
    public init(title: String, elements: [CategoryPickerItem<T>], onSelect: @escaping (T) -> Void) {
        self.init(isRoot: true, breadCrumb: title, elements: elements, onSelect: onSelect)
    }
    
    private init(isRoot: Bool = false, breadCrumb: String, elements: [CategoryPickerItem<T>], onSelect: @escaping (T) -> Void) {
        self.isRoot = isRoot
        self.title = breadCrumb
        let elements = elements.unwrapSingleElements()
        self.values = elements.values()
        self.categories = elements.categories()
        self.onSelect = onSelect
    }
    
    private func grid(for elements: [CategoryPickerItem<T>]) -> some View {
        LazyVGrid(columns: .init(repeating: GridItem(.flexible(minimum: 32), spacing: 14), count: 3)) {
            ForEach(enumerated: elements) { (index, element) in
                Button {
                    itemTapped(element)
                } label: {
                    VStack(spacing: 8) {
                        Spacer()
                        element.image?.renderingMode(.template)
                        Text(element.title).font(.footnote)
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .background(Color.rainbowColors[looping: index])
                    .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
    }
    public var body: some View {
        ScrollView {
            grid(for: values + categories)
        }
        .padding()
        .navigationDestination(for: $selectedElement) {
            if case let .children(array) = $0.value {
                CategoryPicker(breadCrumb: isRoot ? $0.title : "\(title) > \($0.title)", elements: array, onSelect: onSelect)
            } else {
                EmptyView()
            }
        }
        .navigationTitle(title)
    }
    
    private func itemTapped(_ item: CategoryPickerItem<T>) {
        switch item.value {
        case .children: 
            selectedElement = item
        case .value(let s):
            onSelect(s)
        }
    }
}
