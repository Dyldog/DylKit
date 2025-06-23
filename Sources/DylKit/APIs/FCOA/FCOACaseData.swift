//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation
import SwiftSoup

public struct FCOACaseData: Codable, Hashable, HTMLDataElementType {
    public let title: String
    public let category: String
    public let judgementDate: Date
    public let url: URL
    
    public var description: String {
        "\(category)"
    }
    
    public static var mapper: ThrowingBlockInOut<Elements, FCOACaseData> { { elements in
        let element = try elements.get(0)
        
        guard let link = try element.getElementsByTag("a").first() else {
            throw HTMLAPIError.elementNotFound("a", element: element) }
        guard let judgementDate = try element.getElementsByClass("judgmentdate").first() else {
            throw HTMLAPIError.elementNotFound("judgmentdate", element: element) }
        
        guard let category = element.textNodes().last else {
            throw HTMLAPIError.elementNotFound("Last text node", element: element)
        }
        
        return FCOACaseData(
            title: try link.text(),
            category: category.text().trim(),
            judgementDate: try FCOACaseData.date(in: judgementDate.text()),
            url: .init(string: try link.attr("href"))!
        )
    } }
}

enum DateDecodingError: Error {
    case couldntMatchDateString(text: String)
}

extension FCOACaseData {
    private static let months: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    static let dateRegex: NSRegularExpression = try! .init(pattern: "(\\d{1,2} (?:\(months.joined(separator: "|"))) \\d{4})")
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter
    }()
    
    static func date(in text: String) throws -> Date {
        let matches = dateRegex.firstMatchGroups(in: text)
        guard let dateString = matches.first,
              let date = dateFormatter.date(from: dateString) else {
            throw APIError.decoding(DateDecodingError.couldntMatchDateString(text: text))
        }
        
        return date
    }
}
