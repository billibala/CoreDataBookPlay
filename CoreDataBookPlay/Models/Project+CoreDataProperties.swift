//
//  Project+CoreDataProperties.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Project {

    @NSManaged var name: String?
    @NSManaged var serverID: NSNumber?
    @NSManaged var messages: NSSet?

}
