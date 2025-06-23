//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation
import SwiftSoup

public enum HTMLAPIError: Error {
    case elementNotFoundInDocument(String)
    case elementNotFound(String, element: Element)
}
