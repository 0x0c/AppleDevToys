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
        return DecimalStringValidator.isValid(string)
    }

    static func formatedString(_ string: String?, format: Bool = false) -> String? {
        return DecimalStringFormatter.purify(string, format: format)
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
