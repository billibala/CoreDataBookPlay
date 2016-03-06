//
//  AttributeRelationshipConflict.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/2/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Cocoa

class AttributeRelationshipConflict: Scenario/*, ModelConfigurator*/ {
	
	var contextA: NSManagedObjectContext!
	var contextB: NSManagedObjectContext!
	
	func prepareSeedData() {
		// create the model
		let modelManager = ModelManager(playPurpose: "AttributeRelationshipConflict")
		let seedContext = modelManager.createRootContext(.MainQueueConcurrencyType)
		seedContext.createTestProject(4, numberOfMessages: 16)
		seedContext.saveChanges()
	}
	
//	func run() {
//		// create the model
//		let modelManager = ModelManager(playPurpose: "AttributeRelationshipConflict")
//		contextA = modelManager.createRootContext(.PrivateQueueConcurrencyType)
//		contextB = modelManager.createRootContext(.PrivateQueueConcurrencyType)
//		
//		/*
//		Scenario detail...
//		
//		Both Context `A` and Context `B`
//		* Fetch Project A
//		
//		`A`:
//		
//		* Modify relationship of "Project A" by adding a new message to it.
//		* Save the change
//		
//		`B`
//		
//		* Modify attribute of "Project A". Say, change the name of the project.
//		* Save the change
//		
//		Expectation, on saving context `B`, exception will be raised.
//		*/
//		
//		var projectA: Project!
//		contextA.performBlockAndWait {
//			// fetch project
//			projectA = try! Project.anyInContext(self.contextA)
//		}
//		
//		var projectB: Project!
//		contextB.performBlockAndWait {
//			// fetch project
//			if let theProject = try! self.contextB.existingObjectWithID(projectA.objectID) as? Project {
//				projectB = theProject
//			}
//		}
//		
//		contextA.performBlockAndWait {
//			// modify relationship here
//			let message = Message.insertInContext(self.contextA)
//			message.project = projectA
//			message.title = "Testing Title"
//			message.serverID = 12345
//			// save changes
//			self.contextA.saveChanges()
//		}
//		
//		contextB.performBlockAndWait {
//			// modify attribute
//			projectB.name = "Change it to something else"
//			// save changes
//			self.contextB.saveChanges()
//		}
//	}

	func run() {
		// create the model
		let modelManager = ModelManager(playPurpose: "AttributeRelationshipConflict")
		contextA = modelManager.createRootContext(.PrivateQueueConcurrencyType)
		contextB = modelManager.createRootContext(.PrivateQueueConcurrencyType)
		
		/*
		Scenario detail...
		
		Both Context `A` and Context `B`
		* Fetch Project A
		
		`B`
		
		* Modify attribute of "Project A". Say, change the name of the project.
		* Save the change
		
		`A`:
		
		* Modify relationship of "Project A" by adding a new message to it.
		* Save the change
		
		Expectation, on saving context `A`, exception will be raised.
		*/
		
		var projectA: Project!
		contextA.performBlockAndWait {
			// fetch project
			projectA = try! Project.anyInContext(self.contextA)
		}
		
		var projectB: Project!
		contextB.performBlockAndWait {
			// fetch project
			if let theProject = try! self.contextB.existingObjectWithID(projectA.objectID) as? Project {
				projectB = theProject
			}
		}
		
		contextB.performBlockAndWait {
			// modify attribute
			projectB.name = "Change it to something else"
			// save changes
			self.contextB.saveChanges()
		}
		
		contextA.performBlockAndWait {
			// modify relationship here
			let message = Message.insertInContext(self.contextA)
			message.project = projectA
			message.title = "Testing Title"
			message.serverID = 12345
			// save changes
			self.contextA.saveChanges()
		}
	}
}