//
//  ContentView.swift
//  DylKitDemo
//
//  Created by Dylan Elliott on 21/6/2023.
//

import SwiftUI
import DylKit

enum Defaults: String, DefaultsKey {
    case testString
}

struct UserDefaultableViewModel {
    @UserDefaultable(key: Defaults.testString) var testString: String = "Hello"
}

struct UserDefaultableView: View {
    @State var viewModel: UserDefaultableViewModel = .init()
    
    
    var body: some View {
        VStack(spacing: 50) {
            Text("""
            The value below will be stored in UserDefaults. Change it and relaunch the app and see that it is persisted.
            """)
            .multilineTextAlignment(.center)
                
            TextField("Text", text: $viewModel.testString)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
        }
        .padding(30)
    }
}

struct UserDefaultableView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultableView()
    }
}
