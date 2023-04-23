//
//  AppDelegate.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 14/03/23.
//

import Cocoa
import Foundation
import Network

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
        constructMenu()
    }
        
    @objc func JSONfy(_ sender: Any?) {
        SNJson.jsonfy()
    }
    
    @objc func myIp(_ sender: Any?) {
        if let button = statusItem.button {
            SNIpv4.shared.toggle(sender: sender, display: (relativeTo: button.bounds, view: button, preferredEdge: .minY))
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Beaufy JSON",
                                action: #selector(AppDelegate.JSONfy(_:)),
                                keyEquivalent: "J"))
        
        menu.addItem(NSMenuItem(title: "My IP",
                                action: #selector(AppDelegate.myIp(_:)),
                                keyEquivalent: "I"))
        
        menu.addItem(NSMenuItem.separator())
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
}
