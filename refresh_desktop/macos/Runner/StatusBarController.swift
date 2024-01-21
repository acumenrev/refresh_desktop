//
//  StatusBarController.swift
//  Runner
//
//  Created by trivo on 21/01/2024.
//

import AppKit

class StatusBarController {
    // Instance of the status bar
    private var appStatusBar: NSStatusBar

    // Instance of the status bar item
    private var statusBarMenuItem: NSStatusItem

    // Instance of the popover that will display the Flutter UI
    private var flutterUIPopover: NSPopover

    // Initializer for the StatusBarController class
    init(_ popover: NSPopover) {
        self.flutterUIPopover = popover
        appStatusBar = NSStatusBar.init()
        statusBarMenuItem = NSStatusBar.system.statusItem(withLength: 28)

        // Configure the status bar item's button
        if let statusBarMenuButton = statusBarMenuItem.button {
            // Set the button's image
            // NSImage.Name("mac16.png")
            statusBarMenuButton.image = NSImage(imageLiteralResourceName: "smile") // Change this to your desired image
            statusBarMenuButton.image?.size = NSSize(width: 18.0, height: 18.0)
            statusBarMenuButton.image?.isTemplate = true

            // Set the button's action to toggle the popover when clicked
            statusBarMenuButton.action = #selector(togglePopover(sender:))
            statusBarMenuButton.target = self
        }
    }

    // Function to toggle the popover when the status bar item's button is clicked
    @objc func togglePopover(sender: AnyObject) {
        if(flutterUIPopover.isShown) {
            hidePopover(sender)
        }
        else {
            showPopover(sender)
        }
    }

    // Function to show the popover
    func showPopover(_ sender: AnyObject) {
        if let statusBarMenuButton = statusBarMenuItem.button {
            flutterUIPopover.show(relativeTo: statusBarMenuButton.bounds, of: statusBarMenuButton, preferredEdge: NSRectEdge.maxY)
        }
    }

    // Function to hide the popover
    func hidePopover(_ sender: AnyObject) {
        flutterUIPopover.performClose(sender)
    }
}

