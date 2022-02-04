//
//  HexadecimalTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class HexadecimalTextFormViewModel: TextFormViewModel {
    var formatText = false
    var uppercase = false

    static func alloewdString(_ string: String) -> Bool {
        if string == "00" {
            return false
        }
        return string.replacingOccurrences(of: " ", with: "").purify(radix: 16)?.toInteger(radix: 16) != nil
    }

    static func formatedString(_ string: String?, format: Bool = false, uppercase: Bool = false) -> String? {
        if var ss = string, ss.count > 1, let char = ss.first, char == "0" {
            ss.removeFirst()
            return String(ss)
        }
        var numberString: String? {
            if uppercase {
                return string?.uppercased()
            }
            return string?.lowercased()
        }
        let str = numberString?.replacingOccurrences(of: " ", with: "").purify(radix: 16)
        if format {
            return str?.formatted(radix: 16)
        }
        return str
    }

    required init(isEditable: Bool) {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Hex",
                isEditable: isEditable
            ),
            defaultString: "0",
            allowedStringHandler: { string in
                return HexadecimalTextFormViewModel.alloewdString(string)
            }
        )
        formatHandler = { [unowned self] string in
            return HexadecimalTextFormViewModel.formatedString(string, format: self.formatText, uppercase: self.uppercase)
        }
    }
}
