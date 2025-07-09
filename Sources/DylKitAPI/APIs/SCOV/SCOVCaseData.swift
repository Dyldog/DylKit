//
//  File.swift
//  
//
//  Created by Dylan Elliott on 9/7/2025.
//

import Foundation
import DylKit
import SwiftSoup

public struct SCOVCaseData: Codable, Hashable, HTMLDataElementType {
    public let title: String
    public let judgementDate: Date
    public let path: String
    public var url: URL { SCOVAPI.baseURL.appendingPathComponent(path) }
    public var description: String { "" }
    
    public static var mapper: ThrowingBlockInOut<Elements, SCOVCaseData> { { elements in
        let element = try elements.get(0)
        
        guard let link = try element.getElementsByTag("a").first() else {
            throw HTMLAPIError.elementNotFound("a", element: element) }
        
        return SCOVCaseData(
            title: try link.text(),
            judgementDate: try SCOVCaseData.date(in: link.text()),
            path: try link.attr("href")
        )
    } }
}

extension SCOVCaseData {
    private static let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    static let dateRegex: NSRegularExpression = try! .init(pattern: "(\\d{1,2} (?:\(months.joined(separator: "|"))) \\d{4})")
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"
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

