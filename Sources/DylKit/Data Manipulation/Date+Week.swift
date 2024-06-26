//
//  File.swift
//  
//
//  Created by Dylan Elliott on 7/5/2024.
//

import Foundation

public extension Date {
	var startOfWeek: Date {
		let gregorian = Calendar(identifier: .gregorian)
		let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
		return gregorian.date(byAdding: .day, value: 1, to: sunday)!
	}
	
	var endOfWeek: Date? {
		let gregorian = Calendar(identifier: .gregorian)
		guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
		return gregorian.date(byAdding: .day, value: 7, to: sunday)
	}
}
