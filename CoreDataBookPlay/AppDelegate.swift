//
//  AppDelegate.swift
//  CoreDataBookPlay
//
//  Created by Bill So on 2/27/16.
//  Copyright © 2016 Bill So. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var window: NSWindow!


	func applicationDidFinishLaunching(aNotification: NSNotification) {
		// Insert code here to initialize your application
	}

	func applicationWillTerminate(aNotification: NSNotification) {
		// Insert code here to tear down your application
	}

	@IBAction func pickContextHierarchy(sender: AnyObject) {
	}
	
	@IBAction func pickConflictCase(sender: AnyObject) {
	}
	
	@IBAction func prepareDataStack(sender: AnyObject) {
	}
	
	@IBAction func runScenario(sender: AnyObject) {
		print("hello, run scenario")
	}
}

