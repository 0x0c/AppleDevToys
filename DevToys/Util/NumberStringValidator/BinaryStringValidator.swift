//
//  BinaryStringValidator.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

class BinaryStringValidator: NumberStringValidator {
    static func isValid(_ string: String) -> Bool {
        return string.replacingOccurrences(of: " ", with: "").purify(radix: 2)?.toInteger(radix: 2) != nil
    }
}
