//
//  File.swift
//  
//
//  Created by Dylan Elliott on 9/7/2025.
//

import DylKit
import Foundation
import SwiftSoup

public struct SCOVCaseListData: HTMLDataType, Codable {
    public let cases: [SCOVCaseData]
    
    public static var mapper: ThrowingBlockInOut<Document, SCOVCaseListData> { { document in
        guard let content = try? document.getElementById("results-listing") else {
            throw HTMLAPIError.elementNotFoundInDocument("#results-listing")
        }
        
        guard let list = try? content.getElementsByTag("ul").first() else {
            throw HTMLAPIError.elementNotFound("ul", element: content)
        }
        
        let cases = try list.getElementsByTag("li").map {
            try SCOVCaseData.mapper(.init([$0]))
        }
        
        return .init(cases: cases)
    } }
}
