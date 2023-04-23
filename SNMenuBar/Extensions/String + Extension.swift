//
//  String + Extension.swift
//  SNMenuBar
//
//  Created by Matheus D Sanada on 15/03/23.
//

import Cocoa

extension String {
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
}
