//
//  ModelManager.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 2/28/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Cocoa

/// Creates managed object context and prepare new SQLite store.
class ModelManager {
	let storeURL: NSURL
	/// The reason why this model manager is created. Use this a unique identifier of the manager and data store location.
	let playPurpose: String
	
	private static var applicationDocumentsDirectory: NSURL {
		// The directory the application uses to store the Core Data store file. This code uses a directory named "com.headnix.CoreDataBookPlay" in the user's Application Support directory.
		let urls = NSFileManager.defaultManager().URLsForDirectory(.ApplicationSupportDirectory, inDomains: .UserDomainMask)
		let appSupportURL = urls[urls.count - 1]
		return appSupportURL.URLByAppendingPathComponent("com.headnix.CoreDataBookPlay")
	}

	private var managedObjectModel: NSManagedObjectModel {
		// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
		let modelURL = NSBundle.mainBundle().URLForResource("CoreDataBookPlay", withExtension: "momd")!
		return NSManagedObjectModel(contentsOfURL: modelURL)!
	}

	init(playPurpose: String) {
		// create file URL
		let appSupportURL = ModelManager.applicationDocumentsDirectory
		storeURL = appSupportURL.URLByAppendingPathComponent("\(playPurpose)/CoreDataBookPlay.sqlite")
		self.playPurpose = playPurpose
	}
	
	private func prepareStoreDirectory() throws {
		let parentPath = storeURL.URLByDeletingLastPathComponent!
		
		let fileManager = NSFileManager.defaultManager()
		
		do {
			let properties = try parentPath.resourceValuesForKeys([NSURLIsDirectoryKey])
			if !properties[NSURLIsDirectoryKey]!.boolValue {
				// the path is not a folder!! Throw error
				let error = NSError(domain: "ModelManagerErrorDomain", code: -999, userInfo: nil)
				throw error
			}
		} catch {
			let nserror = error as NSError
			if nserror.code == NSFileReadNoSuchFileError {
				try fileManager.createDirectoryAtPath(parentPath.path!, withIntermediateDirectories: true, attributes: nil)
			}
			throw error
		}
	}
	
	func createRootContext(concurrencyType: NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
		try! prepareStoreDirectory()
		
		let context = NSManagedObjectContext(concurrencyType: concurrencyType)
		let modelSchema = self.managedObjectModel
		let psc = NSPersistentStoreCoordinator(managedObjectModel: modelSchema)
		try! psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
		context.persistentStoreCoordinator = psc
		return context
	}
	
	func removeStore() {
		// Delete the SQLite file
	}
}