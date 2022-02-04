//
//  OctalTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class OctalTextFormViewModel: TextFormViewModel {
    var formatText = false

    static func alloewdString(_ string: String) -> Bool {
        if string.contains(" ") {
            return false
        }
        if string == "00" {
            return false
        }
        return string.purify(radix: 8)?.toInteger(radix: 8) != nil
    }

    required init(isEditable: Bool) {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Octal",
                isEditable: isEditable
            ),
            defaultString: "0",
            allowedStringHandler: { string in
                return OctalTextFormViewModel.alloewdString(string)
            }
        )
        self.formatHandler = { [unowned self] string in
            if var ss = string, let char = ss.first, char == "0" {
                return String(ss.removeLast())
            }
            let str = string?.purify(radix: 8)
            if self.formatText {
                return str?.formatted(radix: 8)
            }
            return str
        }
    }
}
