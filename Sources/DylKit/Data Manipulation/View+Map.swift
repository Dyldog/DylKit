//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import SwiftUI

public extension View {
    func map<T: View>(_ work: (Self) -> T) -> T {
        return work(self)
    }
}
