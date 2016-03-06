//
//  NSManagedObjectContext+Extensions.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Cocoa

extension NSManagedObjectContext {
	func createChildContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
		let context = NSManagedObjectContext(concurrencyType: concurrencyType)
		context.parentContext = self
		return context
	}
	
	func saveChanges() {
		if hasChanges {
			do {
				try save()
			} catch {
				let myError = error as NSError
				print("\(myError.domain) - error \(myError.code)")
				// dig up the difference
				guard let conflictList = myError.userInfo["conflictList"] as? [NSMergeConflict] else {
					fatalError("it's not a merge conflict error (\(NSManagedObjectMergeError)). Check error code: \(myError.code)")
				}
				// go through the conflict list
				for conflict in conflictList {
					print("changed values:\n\(conflict.sourceObject.changedValues())")
				}
			}
		}
	}
}
