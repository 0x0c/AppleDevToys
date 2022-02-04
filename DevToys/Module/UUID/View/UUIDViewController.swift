//
//  UUIDViewController.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Combine
import UIKit

protocol UUIDViewInput: AnyObject {
    // MARK: Callback from presenter
}

final class UUIDViewController: UIViewController {
    // MARK: Stored instance properties

    var presenter: UUIDPresenterInput!

    // MARK: Computed instance properties

    @IBOutlet private var backgroundViews: [UIView]!
    private var cancellable = Set<AnyCancellable>()

    // MARK: IBOutlets
    @IBOutlet private var hyphenateSwitch: UISwitch!
    @IBOutlet private var uppercaseSwitch: UISwitch!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var numberOfUUIDsTextField: UITextField!

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UUID Generator"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        textView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        numberOfUUIDsTextField.delegate = self
        backgroundViews.forEach {
            $0.layer.cornerRadius = Constant.defaultCornerRadius
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTextUpdate),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
        presenter.viewDidLoad()
    }

    // MARK: Other private methods
    @IBAction private func didPlusButtonPress(_ sender: Any) {
        if let text = numberOfUUIDsTextField.text,
           var number = Int(text) {
            number += 1
            numberOfUUIDsTextField.text = String(number)
        }
    }

    @IBAction private func didMinusButtonPress(_ sender: Any) {
        if let text = numberOfUUIDsTextField.text,
           var number = Int(text) {
            number -= 1
            numberOfUUIDsTextField.text = String(max(number, 0))
        }
    }

    @IBAction private func didGenerateButtonPress(_ sender: Any) {
        if let text = numberOfUUIDsTextField.text,
           let numberOfUUIDs = Int(text) {
            var uuids = [String]()
            for _ in 0..<numberOfUUIDs {
                var uuidString = UUID().description
                if hyphenateSwitch.isOn == false {
                    uuidString = uuidString.replacingOccurrences(of: "-", with: "")
                }
                if uppercaseSwitch.isOn {
                    uuidString = uuidString.uppercased()
                }
                else {
                    uuidString = uuidString.lowercased()
                }
                uuids.append(uuidString)
            }
            if textView.text.isEmpty == false {
                textView.text.append("\n")
            }
            textView.text = uuids.joined(separator: "\n")
        }
    }

    @IBAction private func didClearButtonPress(_ sender: Any) {
        textView.text = nil
    }

    @objc
    private func didTextUpdate() {
        if numberOfUUIDsTextField.text == nil {
            numberOfUUIDsTextField.text = "0"
        }
        else if let text = numberOfUUIDsTextField.text {
            if text.isEmpty || text == "00" {
                numberOfUUIDsTextField.text = "0"
            }
            else {
                numberOfUUIDsTextField.text =
                DecimalStringFormatter.purify(text)
            }
        }
    }
}

extension UUIDViewController: UUIDViewInput {}

extension UUIDViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        return DecimalTextFormViewModel.alloewdString(string)
    }
}
