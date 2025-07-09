//
//  File.swift
//  
//
//  Created by Dylan Elliott on 9/7/2025.
//

import Foundation

public enum SCOVAPI {
    static var baseURL: URL { .init(string: "https://www6.austlii.edu.au")! }
    static let defaultParameters: [String : String] = [:]
    
    public static let allCases: HTMLAPI<EmptyInput, SCOVCaseListData> = .init(
        baseURL: SCOVAPI.baseURL, path: "/cgi-bin/viewdb/au/cases/vic/VSC")
}
