//
//  DecimalStringFormatter.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

class DecimalStringFormatter: NumberStringFormatter {
    static func purify(_ string: String?, format: Bool = false) -> String? {
        if var ss = string, ss.count > 1, let char = ss.first, char == "0" {
            ss.removeFirst()
            return String(ss)
        }
        let str = string?.replacingOccurrences(of: " ", with: "").purify(radix: 10)
        if format {
            return str?.formatted(radix: 10)
        }
        return str
    }
}
