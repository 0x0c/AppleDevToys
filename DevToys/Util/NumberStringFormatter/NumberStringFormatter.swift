//
//  NumberStringFormatter.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/05.
//

import Foundation

protocol NumberStringFormatter {
    static func purify(_ string: String?, format: Bool) -> String?
}
