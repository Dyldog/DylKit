//
//  File.swift
//
//
//  Created by Dylan Elliott on 3/1/2024.
//

import SwiftUI


public struct CodableImage: Codable {
#if canImport(UIKit)
    public let image: UIImage
#else
    public let image: NSImage
#endif
    
    public enum CodingKeys: String, CodingKey {
        case image
    }
    
#if canImport(UIKit)
    public init(image: UIImage) {
        self.image = image
    }
#else
    public init(image: NSImage) {
        self.image = image
    }
#endif
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
#if canImport(UIKit)
        let image = UIImage(data: data)
#else
        let image = NSImage(data: data)
#endif
        guard let image = image else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.image], debugDescription: "Couldn't decode image from data"))
        }
        
        self.image = image
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
#if canImport(UIKit)
        let data = image.pngData()
#else
        let data = image.tiffRepresentation
#endif
        guard let data = data else {
            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.image], debugDescription: "Couldn't encode image to data"))
        }
        
        try container.encode(data, forKey: CodingKeys.image)
    }
}
