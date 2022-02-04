//
//  NumberStringValidator.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

protocol NumberStringValidator {
    static func isValid(_ string: String) -> Bool
}
