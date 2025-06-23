//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation
import SwiftSoup

public struct SCOTUSCaseData: Codable, Hashable, HTMLDataElementType {
    public let title: String
    public let date: Date
    public let description: String
    let path: String
    
    public var url: URL { SCOTUSAPI.baseURL.appendingPathComponent(path) }
    
    public static var mapper: ThrowingBlockInOut<Elements, SCOTUSCaseData> { { elements in
        let first = try elements.get(0).getElementsByTag("a")[0]
        let second = elements.get(1)
        
        return SCOTUSCaseData(
            title: try first.text(),
            date: try SCOTUSCaseData.date(in: second.text()),
            description: try second.text(),
            path: try first.attr("href")
        )
    } }
}

extension SCOTUSCaseData {
    private static let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    static let dateRegex: NSRegularExpression = try! .init(pattern: "((?:\(months.joined(separator: "|"))) \\d{1,2}, \\d{4})")
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
    
    static func date(in text: String) throws -> Date {
        let matches = dateRegex.allMatchGroups(in: text)
        guard let dateString = matches.last,
              let date = dateFormatter.date(from: dateString) else {
            throw APIError.decoding(DateDecodingError.couldntMatchDateString(text: text))
        }
        
        return date
    }
}
