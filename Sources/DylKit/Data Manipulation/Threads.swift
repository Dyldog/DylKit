//
//  File.swift
//  
//
//  Created by Dylan Elliott on 20/10/2023.
//

import Foundation

public func onMain(_ work: @escaping () -> Void) {
    DispatchQueue.main.async {
        work()
    }
}

public func onMainSync(_ work: @escaping () -> Void) {
    DispatchQueue.main.sync {
        work()
    }
}


public func onBG(_ work: @escaping () -> Void) {
    DispatchQueue.global().async {
        work()
    }
}
