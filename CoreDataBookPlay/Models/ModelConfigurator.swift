//
//  ModelConfigurator.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 3/3/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Foundation

enum ContextHierarchy {
	case Independent
	case ParentMainChild
	
	
}

class ModelConfigurator {
	let hierarchy: ContextHierarchy
	
	init(hierarchy: ContextHierarchy) {
		self.hierarchy = hierarchy
	}
	
	
}