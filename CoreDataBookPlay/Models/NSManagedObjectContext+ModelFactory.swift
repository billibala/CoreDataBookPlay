//
//  NSManagedObjectContext+ModelFactory.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Cocoa

/**
A collection of factory methods for seeding data
*/
extension NSManagedObjectContext {
	
	/// Create test projects and messages
	func createTestProject(numberOfProjects: Int = 1, numberOfMessages: Int = 1) {
		precondition(numberOfMessages > 0 && numberOfProjects > 0)
		for index in 1...numberOfProjects {
			guard let project = NSEntityDescription.insertNewObjectForEntityForName("Project", inManagedObjectContext: self) as? Project else {
				fatalError()
			}
			project.name = "Project \(index)"
			project.serverID = index
			// create messages
			
			for msgIndex in 1...numberOfMessages {
				guard let message = NSEntityDescription.insertNewObjectForEntityForName("Message", inManagedObjectContext: self) as? Message else {
					fatalError()
				}
				message.title = "Message in project \(index) Title \(msgIndex)"
				message.rawBody = "Hello world! \(index) - \(msgIndex)"
				message.project = project
			}
		}
		
		self.saveChanges()
	}
}
