//
//  File.swift
//  
//
//  Created by Dylan Elliott on 25/1/2025.
//

#if canImport(UIKit)
import UIKit

public extension UIApplication {
    var name: String {
        Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
}

#endif
