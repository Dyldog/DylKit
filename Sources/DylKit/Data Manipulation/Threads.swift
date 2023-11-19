//
//  File.swift
//  
//
//  Created by Dylan Elliott on 20/10/2023.
//

import Foundation

func onMain(_ work: @escaping () -> Void) {
    DispatchQueue.main.async {
        work()
    }
}

func onBG(_ work: @escaping () -> Void) {
    DispatchQueue.global().async {
        work()
    }
}
