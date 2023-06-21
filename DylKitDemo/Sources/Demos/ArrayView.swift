//
//  ArrayView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 22/6/2023.
//

import SwiftUI

struct DataDemonstrationSection<T>: View {
    let title: String
    let input: [T]
    let work: ([T]) -> [T]
    
    var body: some View {
        Section(header: Text(title)) {
            Text("Input: \(input.description)")
            Text("Output: \(work(input).description)")
            Text("Again: \(work(work(input)).description)")
        }
    }
}

struct ArrayView: View {
    var body: some View {
        List {
            DataDemonstrationSection(title: "Rotated", input: Array(0...10), work: {
                $0.rotated(3)
            })
            
            DataDemonstrationSection(title: "Repeated", input: Array(0...2), work: {
                $0.repeated(2)
            })
        }
    }
}
