//
//  File.swift
//  
//
//  Created by Dylan Elliott on 7/5/2024.
//

import Foundation

public extension TimeInterval {
	static var oneSecond: TimeInterval { 1 }
	static var oneMinute: TimeInterval { 60 * .oneSecond }
	static var oneHour: TimeInterval { 60 * .oneMinute }
	static var oneDay: TimeInterval { 24 * .oneHour }
	static var oneWeek: TimeInterval { 7 * .oneDay }
    static var oneMonth: TimeInterval { 30 * .oneDay }
    static var oneYear: TimeInterval { 365 * .oneDay }
}
