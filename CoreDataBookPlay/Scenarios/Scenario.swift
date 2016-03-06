//
//  Scenario.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/2/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Foundation

protocol Scenario {
	/// Prepare seed data
	func prepareSeedData()
	
	/// Run the scenario which includes manufacturing the data issue.
	func run()
}