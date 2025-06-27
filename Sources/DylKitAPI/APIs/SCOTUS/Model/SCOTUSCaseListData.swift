//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import DylKit
import Foundation
import SwiftSoup

public struct SCOTUSCaseListData: HTMLDataType, Codable {
    public let cases: [SCOTUSCaseData]
    
    public static var mapper: ThrowingBlockInOut<Document, SCOTUSCaseListData> { { document in
        guard let content = try? document.getElementById("content1") else {
            throw HTMLAPIError.elementNotFoundInDocument("#content1")
        }
        
        guard let list = try? content.getElementsByTag("dl").first() else {
            throw HTMLAPIError.elementNotFoundInDocument("dl")
        }
        
        let cases = try list.children().filter { $0.tag().getName() != "br" }.chunked(into: 2).map { elements in
            try SCOTUSCaseData.mapper(.init(elements))
        }
        
        return SCOTUSCaseListData(cases: cases)
    } }
}
