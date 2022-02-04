//
//  DecimalTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class DecimalTextFormViewModel: TextFormViewModel {
    var formatText = false

    static func alloewdString(_ string: String) -> Bool {
        if string == "00" {
            return false
        }
        return string.replacingOccurrences(of: " ", with: "").purify(radix: 10)?.toInteger(radix: 10) != nil
    }

    static func formatedString(_ string: String?, format: Bool = false) -> String? {
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

    required init(isEditable: Bool) {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Decimal",
                isEditable: isEditable
            ),
            defaultString: "0",
            allowedStringHandler: { string in
                return DecimalTextFormViewModel.alloewdString(string)
            }
        )
        formatHandler = { [unowned self] string in
            return DecimalTextFormViewModel.formatedString(string, format: self.formatText)
        }
    }
}
