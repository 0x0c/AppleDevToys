//
//  OctalStringValidator.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

class OctalStringValidator: NumberStringValidator {
    static func isValid(_ string: String) -> Bool {
        if string == "00" {
            return false
        }
        return string.replacingOccurrences(of: " ", with: "").purify(radix: 8)?.toInteger(radix: 8) != nil
    }
}
