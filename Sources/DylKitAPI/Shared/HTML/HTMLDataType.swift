//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import DylKit
import Foundation
import SwiftSoup

public protocol HTMLDataType {
    static var mapper: ThrowingBlockInOut<Document, Self> { get }
}

public protocol HTMLDataElementType {
    static var mapper: ThrowingBlockInOut<Elements, Self> { get }
}
