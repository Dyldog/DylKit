//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import DylKit
import Foundation
import SwiftSoup

public struct FCOACaseListData: HTMLDataType, Codable {
    public let cases: [FCOACaseData]
    
    public static var mapper: ThrowingBlockInOut<Document, FCOACaseListData> { { document in
        guard let content = try? document.getElementById("content") else {
            throw HTMLAPIError.elementNotFoundInDocument("#content")
        }
        
        guard let list = try? content.getElementsByTag("ul").first() else {
            throw HTMLAPIError.elementNotFound("ul", element: content)
        }
        
        let cases = try list.getElementsByTag("li").map {
            try FCOACaseData.mapper(.init([$0]))
        }
        
        return .init(cases: cases)
    } }
}
