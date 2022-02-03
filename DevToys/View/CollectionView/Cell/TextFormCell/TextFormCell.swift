//
//  TextFormCell.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Reusable
import UIKit

final class TextFormCell: UICollectionViewCell, NibReusable, TextFormCellProtocol {
    static let defaultHeight: CGFloat = 56

    var shouldValidate = false
    var shouldSkipFirstValidation = true
    var errorLabel: UILabel? {
        return baseErrorLabel
    }

    var textField: UITextField {
        return baseTextField
    }

    var viewModel: TextFormAvailable? {
        didSet {
            guard let viewModel = viewModel as? TextFormViewModel else {
                return
            }
            cancellable.removeAll()
            textField.text = viewModel.text
            textField.isSecureTextEntry = viewModel.textForm.isSecureTextEntry
            textField.placeholder = viewModel.textForm.placeholder
            textField.keyboardType = viewModel.textForm.keyboardType
            textField.spellCheckingType = viewModel.textForm.spellCheckingType
            textField.autocorrectionType = viewModel.textForm.autocorrectionType
            textField.autocapitalizationType = viewModel.textForm.autocapitalizationType
            textField.passwordRules = viewModel.textForm.passwordRules
            if let contentType = viewModel.textForm.contentType {
                textField.textContentType = contentType
            }
            viewModel.shuldFocusSubject.sink { [weak self] _ in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.textField.becomeFirstResponder()
            }.store(in: &cancellable)
            viewModel.$text.removeDuplicates().sink { [weak self] string in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.textField.text = string
            }.store(in: &cancellable)
            NotificationCenter.default.publisher(
                for: UITextField.textDidChangeNotification,
                object: textField
            ).sink { [weak self] _ in
                guard let weakSelf = self, let viewModel = weakSelf.viewModel as? TextFormViewModel else {
                    return
                }
                if weakSelf.shouldValidate {
                    weakSelf.validate()
                }
                viewModel.update(text: weakSelf.textField.text)
            }.store(in: &cancellable)
            NotificationCenter.default.publisher(
                for: TextFormSection.performResignFirstResponder
            ).sink { [weak self] _ in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.textField.resignFirstResponder()
            }.store(in: &cancellable)
        }
    }

    private var cancellable = Set<AnyCancellable>()
    @IBOutlet private var baseErrorLabel: UILabel!
    @IBOutlet private var baseTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textField.delegate = self
        errorLabel?.alpha = 0
        layer.cornerRadius = 7
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTextUpdate),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        textField.isSecureTextEntry = false
        errorLabel?.text = nil
        validate()
    }

    @objc
    private func didTextUpdate() {
        if let viewModel = viewModel as? TextFormViewModel {
            if let text = textField.text, text.isEmpty {
                textField.text = viewModel.defaultString
            }
        }
    }
}

extension TextFormCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validate()
        guard let viewModel = viewModel as? TextFormViewModel else {
            return false
        }
        if string.isEmpty {
            return true
        }
        var currentText: String {
            if let text = textField.text {
                return text
            }
            return ""
        }
        let newString = currentText.appending(string)
        guard let handler = viewModel.allowedStringHandler else {
            viewModel.update(text: newString)
            textField.text = viewModel.text
            return false
        }
        if handler(newString) {
            viewModel.update(text: newString)
            textField.text = viewModel.text
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        shouldSkipFirstValidation = false
        validate()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldSkipFirstValidation = false
        validate()
        if viewModel?.focusNext() == false {
            resign()
        }
        return true
    }
}
