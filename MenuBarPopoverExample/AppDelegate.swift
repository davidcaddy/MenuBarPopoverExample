//
//  AppDelegate.swift
//  MenuBarPopoverExample
//
//  Created by David Caddy on 15/6/20.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = self.statusItem.button {
            button.image = NSImage(named: NSImage.Name("ExampleMenuBarIcon"))
            button.action = #selector(AppDelegate.togglePopover(_:))
            
            // Uncomment this to capture right mouse clicks, in addition to left clicks
            //
            // button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        
        self.popover.contentViewController = ViewController.newInstance()
        self.popover.animates = false
        
        self.eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown {
                strongSelf.closePopover(sender: event)
            }
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @objc func togglePopover(_ sender: NSStatusItem) {
        // if sendAction(on: [.leftMouseUp, .rightMouseUp]) is uncommented in applicationDidFinishLaunching
        // This can be used to check the type of the incoming mouse event
        //
        // let event = NSApp.currentEvent!
        // if event.type == NSEvent.EventType.rightMouseUp {
        //     print("Right Click")
        // }
        
        if self.popover.isShown {
            closePopover(sender: sender)
        }
        else {
            showPopover(sender: sender)
        }
    }

    func showPopover(sender: Any?) {
        if let button = self.statusItem.button {
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            self.eventMonitor?.start()
        }
    }

    func closePopover(sender: Any?) {
        self.popover.performClose(sender)
        self.eventMonitor?.stop()
    }
}
