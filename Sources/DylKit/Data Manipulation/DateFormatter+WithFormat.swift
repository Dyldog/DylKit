//
//  File.swift
//
//
//  Created by Dylan Elliott on 7/5/2024.
//

import Foundation

public extension DateFormatter {
	convenience init(format: String) {
		self.init()
		dateFormat = "dd MMM"
	}
	
	static var relativeFormatter: RelativeDateTimeFormatter = {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full
		return formatter
	}()
}

public extension Date {
	var weeksAgo: String {
		let secondsAgo = -startOfWeek.timeIntervalSince(.now)
		let weeksAgo = Int(secondsAgo / TimeInterval.oneWeek)
		
		switch weeksAgo {
		case 0: return "This week"
		case 1: return "Last week"
		default: return "\(weeksAgo) weeks ago"
		}
	}
	
	var daysFromNow: String {
		let seconds = Calendar.autoupdatingCurrent.startOfDay(for: self).timeIntervalSince(Calendar.autoupdatingCurrent.startOfDay(for:.now))
		let days = Int(seconds / TimeInterval.oneDay)
		
		switch days {
		case 0: return "Today"
		case 1: return "Tomorrow"
		default: return "In \(days) days"
		}
	}
	
	var timeAgo: String {
		return DateFormatter.relativeFormatter.localizedString(for: self, relativeTo: Date())
	}
}
