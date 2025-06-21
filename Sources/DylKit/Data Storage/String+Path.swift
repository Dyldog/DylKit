//
//  File.swift
//  
//
//  Created by Dylan Elliott on 4/6/2025.
//

import Foundation

extension String {
    public var filename: String {
        components(separatedBy: "/").last ?? ""
    }
    
    public var fileTitle: String {
        filename.removingSuffix("." + fileExtension)
    }
    
    public var fileExtension: String {
        components(separatedBy: ".").last ?? ""
    }
}
