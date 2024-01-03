//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/12/2023.
//

import Foundation

public var isWidget: Bool {
    let extensionDict = Bundle.main.infoDictionary?["NSExtension"] as? [String: Any]
    return (extensionDict?["NSExtensionPointIdentifier"] as? String) == "com.apple.widgetkit-extension"
}
