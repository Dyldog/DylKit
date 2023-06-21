//
//  File.swift
//  
//
//  Created by Dylan Elliott on 21/6/2023.
//

import Foundation

extension UserDefaults: DefaultsStore {
    public func set(data: Data?, for key: any DefaultsKey) {
        set(data, forKey: key.rawValue)
    }
    
    public func data(for key: any DefaultsKey) -> Data? {
        data(forKey: key.rawValue)
    }
}
