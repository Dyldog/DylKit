//
//  File.swift
//  
//
//  Created by Dylan Elliott on 18/8/2024.
//

import Foundation

public extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    var negative: CGPoint {
        .init(x: -x, y: -y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        lhs + rhs.negative
    }
    
    var magnitide: CGFloat {
        sqrt(pow(x, 2) + pow(y, 2))
    }
    
    func distance(to other: CGPoint) -> CGFloat {
        (other - self).magnitide
    }
}
