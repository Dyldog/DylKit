//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public enum SCOTUSAPI {
    static var baseURL: URL { .init(string: "https://www.law.cornell.edu")! }
    static let defaultParameters: [String : String] = [:]
    
    public static let allCases: HTMLAPI<SCOTUSCaseListData> = .init(baseURL: SCOTUSAPI.baseURL, path: "/supremecourt/text")
}
