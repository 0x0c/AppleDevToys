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
        return HexadecimalStringValidator.isValid(string)
    }

    static func formatedString(_ string: String?, format: Bool = false, uppercase: Bool = false) -> String? {
        let str = HexadecimalStringFormatter.purify(string, format: format)
        if uppercase {
            return str?.uppercased()
        }
        return str?.lowercased()
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
