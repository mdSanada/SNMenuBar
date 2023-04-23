//
//  Data Extension.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 15/03/23.
//

import Cocoa

extension Data {
    public var json: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.withoutEscapingSlashes]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
        
        return prettyPrintedString
    }
    
    public var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
        
        return prettyPrintedString
    }
}
