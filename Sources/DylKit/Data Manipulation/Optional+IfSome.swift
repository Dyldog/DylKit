//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import Foundation

public extension Optional {
    func ifSome(_ work: (Wrapped) -> Void) -> Void {
        if let self {
            work(self)
        }
    }
}
