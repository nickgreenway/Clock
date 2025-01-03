//
//  AppDelegate.swift
//  Clock
//
//  Created by Nick Greenway on 11/15/16.
//  Copyright © 2016 Nick Greenway. All rights reserved.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindow: NSWindow?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Set the window title
        if let mainWindow = NSApplication.shared.windows.first {
            mainWindow.title = "Clock"
        }
    }

    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag, let window = mainWindow {
            window.makeKeyAndOrderFront(self) // Reopen the main window
        }
        return true
    }

    func applicationWillTerminate(_ notification: Notification) {
        // Insert code here to tear down your application
    }
}
