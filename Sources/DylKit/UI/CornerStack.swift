//
//  File.swift
//  
//
//  Created by Dylan Elliott on 19/11/2023.
//

import SwiftUI

public struct CornerStack<Content: View>: View {
    public let corner: Corner
    public let content: () -> Content
    
    public init(corner: Corner, content: @escaping () -> Content) {
        self.corner = corner
        self.content = content
    }
    
    public var body: some View {
        VStack {
            if corner.isBottom {
                Spacer()
            }
            
            HStack {
                if corner.isRight {
                    Spacer()
                }
                
                content()
                
                if corner.isLeft {
                    Spacer()
                }
            }
            
            if corner.isTop {
                Spacer()
            }
            
            
        }
    }
    
    public enum Corner {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        var isTop: Bool { self == .topLeft || self == .topRight }
        var isBottom: Bool { !isTop }
        var isLeft: Bool { self == .topLeft || self == .bottomLeft }
        var isRight: Bool { !isLeft }
    }
    
    enum Side {
        enum Vertical {
            case top
            case bottom
            
            var corners: (Corner, Corner) {
                switch self {
                case .top: return (.topLeft, .topRight)
                case .bottom: return (.bottomLeft, .bottomRight)
                }
            }
            
            var left: Corner { corners.0 }
            var right: Corner { corners.1 }
        }
        
        enum Horizontal {
            case left
            case right
            
            var corners: (Corner, Corner) {
                switch self {
                case .left: return (.topLeft, .bottomLeft)
                case .right: return (.topRight, .bottomRight)
                }
            }
            
            var top: Corner { corners.0 }
            var bottom: Corner { corners.1 }
        }
    }
}
