//
//  Project.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Foundation
import CoreData


class Project: NSManagedObject {
	
	static func anyInContext(moc: NSManagedObjectContext) throws -> Project {
		let fetchRequest = NSFetchRequest(entityName: "Project")
		fetchRequest.fetchLimit = 1
		fetchRequest.returnsObjectsAsFaults = false
		if let result = try! moc.executeFetchRequest(fetchRequest) as? [Project],
		let item = result.first {
			return item
		}
		throw ModelError.EmptyResult
	}

}
