//
//  File.swift
//  
//
//  Created by Dylan Elliott on 22/6/2025.
//

import Foundation

public enum FCOAAPI {
    static var baseURL: URL { .init(string: "https://www.fedcourt.gov.au")! }
    static let defaultParameters: [String : String] = [:]
    
    public static let allCases: HTMLAPI<EmptyInput, FCOACaseListData> = .init(
        baseURL: FCOAAPI.baseURL, path: "//digital-law-library/judgments/latest/last-thirty-days")
}
