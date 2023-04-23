//
//  SNJSON.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 15/03/23.
//

import Foundation

struct SNJson {
    static func jsonfy() {
        let pasteboard = SNPasteboard.read()
        let decode = pasteboard.decodingUnicodeCharacters
        
        let code = decode
            .replacingOccurrences(of: "\\", with: "")
            .replacingOccurrences(of: "\"{", with: "{")
            .replacingOccurrences(of: "}\"", with: "}")
            .replacingOccurrences(of: "\"\"{", with: "{")
            .replacingOccurrences(of: "}\"\"", with: "}")
        
        let data = code.data(using: .utf8)
        if let json = data?.prettyJson {
            SNPasteboard.set(json)
        }
    }
}
