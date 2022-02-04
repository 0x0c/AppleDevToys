//
//  Int+Stringfy.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

extension Int {
    func stringfy(radix: Int, format: Bool = false) -> String? {
        let str = String(self, radix: radix)
        if format {
            return str.formatted(radix: radix)
        }
        return str
    }
}

extension String {
    func purify(radix: Int) -> String? {
        if radix == 10 {
            return replacingOccurrences(of: ",", with: "")
        }
        return replacingOccurrences(of: " ", with: "")
    }

    func formatted(radix: Int) -> String? {
        if radix == 10 {
            if let integer = Int(self, radix: radix) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.groupingSeparator = ","
                formatter.groupingSize = 3
                return formatter.string(from: NSNumber(value: integer))
            }
            return nil
        }

        return String(reversed()).chunked(into: 4).reversed().joined(separator: " ")
    }

    func toInteger(radix: Int) -> Int? {
        return Int(self, radix: radix)
    }
}
