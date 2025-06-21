//
//  File.swift
//  
//
//  Created by Dylan Elliott on 8/6/2025.
//

import Foundation

infix operator ~>

public func ~> <Input, Output>(subject: Input, work: (Input) -> Output) -> Output {
    work(subject)
}
