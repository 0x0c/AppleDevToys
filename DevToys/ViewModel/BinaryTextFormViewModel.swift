//
//  BinaryTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class BinaryTextFormViewModel: TextFormViewModel {
    var formatText = false

    static func alloewdString(_ string: String) -> Bool {
        if string.contains(" ") {
            return false
        }
        return string.purify(radix: 2)?.toInteger(radix: 2) != nil
    }

    static func formatedString(_ string: String?, format: Bool = false) -> String? {
        let str = string?.purify(radix: 2)
        if format {
            return str?.formatted(radix: 2)
        }
        return str
    }

    required init(isEditable: Bool) {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Binary",
                isEditable: isEditable
            ),
            defaultString: "0",
            allowedStringHandler: { string in
                return BinaryTextFormViewModel.alloewdString(string)
            }
        )
        formatHandler = { [unowned self] string in
            return BinaryTextFormViewModel.formatedString(string, format: self.formatText)
        }
    }
}
