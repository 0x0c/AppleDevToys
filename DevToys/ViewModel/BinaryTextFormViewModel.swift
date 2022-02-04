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
        return BinaryStringValidator.isValid(string)
    }

    static func formatedString(_ string: String?, format: Bool = false) -> String? {
        return BinaryStringFormatter.purify(string, format: format)
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
