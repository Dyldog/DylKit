//
//  File.swift
//  
//
//  Created by Dylan Elliott on 30/12/2023.
//

import SwiftUI

public class OptionalBox<T>: ObservableObject {
    @Published public var _value: T?
    public var value: T? {
        get { _value }
        set {
            _value = newValue
            onUpdate(newValue)
        }
    }
    let onUpdate: (T?) -> Void
    
    public var hasValue: Bool { value != nil }
            
    public init(_ value: T?, onUpdate: @escaping (T?) -> Void) {
        self._value = value
        self.onUpdate = onUpdate
    }
    
    public var unwrappedBinding: Binding<T>? {
        guard let value else { return nil }
        
        return .init { [unowned self] in
            self.value!
        } set: { [unowned self] in
            self.value = $0
        }
    }
    
    public var unwrapped: T! {
        get { value }
        set { value = newValue }
    }
}

