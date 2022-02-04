//
//  InputNumberType.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

enum InputNumberType: String, CaseIterable {
    case decimal
    case hexadecimal
    case octal
    case binary

    func radix() -> Int {
        switch self {
        case .decimal:
            return 10
        case .hexadecimal:
            return 16
        case .octal:
            return 8
        case .binary:
            return 2
        }
    }
}
