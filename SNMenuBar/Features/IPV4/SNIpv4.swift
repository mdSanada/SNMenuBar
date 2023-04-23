//
//  SNIpv4.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 15/03/23.
//

import Cocoa

struct SNIpv4 {
    static let shared = SNIpv4()
    let popover = NSPopover()
    
    init() {
        popover.contentViewController = ViewController.freshController()
    }

    internal func toggle(sender: Any?, display: (relativeTo: NSRect, view: NSView, preferredEdge: NSRectEdge)) {
        if popover.isShown {
            close(sender: sender)
        } else {
            let detach = NSSelectorFromString("detach")
            show(sender: sender, display: display)
            if popover.responds(to: detach) {
                popover.perform(detach)
            }
        }
    }
    
    private func show(sender: Any?, display: (relativeTo: NSRect, view: NSView, preferredEdge: NSRectEdge)) {
        popover.show(relativeTo: display.relativeTo,
                     of: display.view,
                     preferredEdge: display.preferredEdge)
    }
    
    private func close(sender: Any?) {
        popover.performClose(sender)
    }
}
