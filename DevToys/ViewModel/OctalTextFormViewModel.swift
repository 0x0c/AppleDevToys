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
        return OctalStringValidator.isValid(string)
    }

    static func formatedString(_ string: String?, format: Bool = false) -> String? {
        return OctalStringFormatter.purify(string, format: format)
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
        formatHandler = { [unowned self] string in
            return OctalTextFormViewModel.formatedString(string, format: self.formatText)
        }
    }
}
