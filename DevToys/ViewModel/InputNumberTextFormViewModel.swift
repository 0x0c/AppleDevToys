//
//  InputNumberTextFormViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Foundation

class InputNumberTextFormViewModel: TextFormViewModel {
    var selectedItem: InputNumberType?

    init() {
        super.init(
            text: "0",
            textForm: TextForm(
                placeholder: "Input"
            ),
            defaultString: "0"
        )
        allowedStringHandler = { [unowned self] string in
            guard let value = self.selectedItem else {
                return false
            }
            switch value {
            case .decimal:
                return DecimalTextFormViewModel.alloewdString(string)
            case .hexadecimal:
                return HexadecimalTextFormViewModel.alloewdString(string)
            case .octal:
                return OctalTextFormViewModel.alloewdString(string)
            case .binary:
                return BinaryTextFormViewModel.alloewdString(string)
            }
        }
        formatHandler = { [unowned self] string in
            guard let value = self.selectedItem else {
                return nil
            }
            switch value {
            case .decimal:
                return DecimalTextFormViewModel.formatedString(string)
            case .hexadecimal:
                return HexadecimalTextFormViewModel.formatedString(string)
            case .octal:
                return OctalTextFormViewModel.formatedString(string)
            case .binary:
                return BinaryTextFormViewModel.formatedString(string)
            }
        }
    }
}
