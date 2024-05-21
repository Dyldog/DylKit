//
//  File.swift
//  
//
//  Created by Dylan Elliott on 7/5/2024.
//

import Foundation

public extension Array {
  func sliced(by dateComponents: Set<Calendar.Component>, for key: KeyPath<Element, Date>) -> [Date: [Element]] {
	let initial: [Date: [Element]] = [:]
	let groupedByDateComponents = reduce(into: initial) { acc, cur in
	  let components = Calendar.current.dateComponents(dateComponents, from: cur[keyPath: key])
	  let date = Calendar.current.date(from: components)!
	  let existing = acc[date] ?? []
	  acc[date] = existing + [cur]
	}

	return groupedByDateComponents
  }
}
