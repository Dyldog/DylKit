//
//  File.swift
//
//
//  Created by Dylan Elliott on 23/4/2025.
//

import SwiftUI

public protocol Pickable: Hashable {
    var title: String { get }
}

public extension Picker {
    init(_ label: String, selection: Binding<SelectionValue>)
    where Label == Text,
    SelectionValue: Pickable, SelectionValue: CaseIterable, SelectionValue.AllCases == [SelectionValue],
    Content == ForEach<[SelectionValue], SelectionValue, Text>
    {
        self.init(label, selection: selection) {
            ForEach(SelectionValue.allCases, id: \.self) { item in
                Text(item.title)
            } as Content
        }
    }

    init(
        _ label: String,
        selection: Binding<SelectionValue>,
        cases: @autoclosure () -> [SelectionValue]
    )
    where Label == Text,
          SelectionValue: Pickable,
          Content == ForEach<[SelectionValue], SelectionValue, Text>
    {
        self.init(label, selection: selection) {
            ForEach(cases(), id: \.self) { item in
                Text(item.title)
            } as Content
        }
    }
}
