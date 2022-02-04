//
//  HexadecimalStringValidator.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

class HexadecimalStringValidator: NumberStringValidator {
    static func isValid(_ string: String) -> Bool {
        if string == "00" {
            return false
        }
        return string.replacingOccurrences(of: " ", with: "").purify(radix: 16)?.toInteger(radix: 16) != nil
    }
}
