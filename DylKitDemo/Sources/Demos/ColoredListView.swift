//
//  ColoredListView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 21/6/2023.
//

import SwiftUI
import DylKit

struct ColoredListView: View {
    let offset: Int
    
    init(offset: Int = 0) {
        self.offset = offset
    }
    
    var body: some View {
        ColoredList(
            title: "Colored List",
            colors: Color.rainbowColors.rotated(offset),
            data: Array(["Red", "Orange", "Yellow", "Green", "Blue", "Indigo", "Violet"].repeated(2).rotated(offset).enumerated())
        ) { index, title in
            NavigationLink {
                ColoredListView(offset: offset + index)
            } label: {
                HStack(alignment: .center) {
                    Text(title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    
                    Image.chevron
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
    }
}
