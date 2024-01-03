//
//  File.swift
//  
//
//  Created by Dylan Elliott on 3/1/2024.
//

import SwiftUI

public struct CodableImage: Codable {
  public let image: UIImage

  public enum CodingKeys: String, CodingKey {
    case image
  }

  public init(image: UIImage) {
    self.image = image
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let data = try container.decode(Data.self, forKey: CodingKeys.image)
    guard let image = UIImage(data: data) else {
        throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.image], debugDescription: "Couldn't decode image from data"))
    }

    self.image = image
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    guard let data = image.pngData() else {
        throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.image], debugDescription: "Couldn't encode image to data"))
    }

    try container.encode(data, forKey: CodingKeys.image)
  }
}
