//
//  BinaryStringFormatter.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

class BinaryStringFormatter: NumberStringFormatter {
    static func purify(_ string: String?, format: Bool = false) -> String? {
        let str = string?.replacingOccurrences(of: " ", with: "").purify(radix: 2)
        if format {
            return str?.formatted(radix: 2)
        }
        return str
    }
}
