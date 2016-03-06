//
//  Message.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Foundation
import CoreData


class Message: NSManagedObject {

	static func insertInContext(context: NSManagedObjectContext) -> Message {
		guard let msg = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: context) as? Message else {
			fatalError("Wrong object")
		}
		return msg
	}

}
