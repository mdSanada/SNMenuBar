//
//  Pasteboard.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 15/03/23.
//

import Foundation
import Cocoa

struct SNPasteboard {
    static func read() -> String {
        let pasteboard = NSPasteboard.general
        let read = pasteboard.pasteboardItems?.first?.string(forType: .string)
        return read ?? ""
    }
    
    static func set(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(text, forType: NSPasteboard.PasteboardType.string)
    }

}
