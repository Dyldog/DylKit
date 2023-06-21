//
//  View+If.swift
//  MovieCal
//
//  Created by Dylan Elliott on 21/2/2023.
//

import Foundation
import SwiftUI

public extension View {
    func `if`(_ condition: Bool, modified: (Self) -> any View) -> AnyView {
        if condition {
            return AnyView(modified(self))
        } else {
            return AnyView(self)
        }
    }
}
