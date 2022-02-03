//
//  BinaryTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class BinaryTextFormViewModel: TextFormViewModel {
    var formatText = false

    required init() {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Binary"
            ),
            defaultString: "0",
            allowedStringHandler: { string in
                return string.purify(radix: 2)?.toInteger(radix: 2) != nil
            }
        )
        self.formatHandler = { [unowned self] string in
            let str = string?.purify(radix: 2)
            if self.formatText {
                return str?.formatted(radix: 2)
            }
            return str
        }
    }
}
