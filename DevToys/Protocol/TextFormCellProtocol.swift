//
//  TextFormCellProtocol.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import UIKit

protocol TextFormCellProtocol: AnyObject {
    var errorLabel: UILabel? { get }
    var textField: UITextField { get }
    var viewModel: TextFormAvailable? { get set }
    var isSecureTextEntry: Bool { get }
    var shouldValidate: Bool { get set }
    var shouldSkipFirstValidation: Bool { get set }

    func focuse() -> Bool
    func resign() -> Bool
    func validate()
}

extension TextFormCellProtocol {
    var isSecureTextEntry: Bool {
        get {
            return textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }

    @discardableResult
    func focuse() -> Bool {
        return textField.becomeFirstResponder()
    }

    @discardableResult
    func resign() -> Bool {
        return textField.resignFirstResponder()
    }

    func validate() {
        guard shouldSkipFirstValidation == false,
              let viewModel = viewModel,
              let handler = viewModel.validationHandler else {
            return
        }
        shouldValidate = true
        if let error = handler(textField.text) {
            errorLabel?.text = error.localizedDescription
            errorLabel?.textColor = viewModel.validationAppearance.errorTextColor(for: error)
            UIView.animate(withDuration: 0.15) { [unowned self] in
                self.errorLabel?.alpha = 1
            }
            textField.textColor = viewModel.validationAppearance.textColor(for: error)
        }
        else {
            UIView.animate(withDuration: 0.15) { [unowned self] in
                self.errorLabel?.alpha = 0
            }
            textField.textColor = UIColor.label
        }
    }
}
