//
//  URLEncodeDecodeViewController.swift
//  DevToys
//
//  Created by Akira on 05/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import Drops
import UIKit

protocol URLEncodeDecodeViewInput: AnyObject {
    // MARK: Callback from presenter
}

final class URLEncodeDecodeViewController: UIViewController {
    // MARK: Stored instance properties

    var presenter: URLEncodeDecodePresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    @IBOutlet private var backgroundViews: [UIView]!
    @IBOutlet private var inputTextView: UITextView!
    @IBOutlet private var outputTextView: UITextView!
    @IBOutlet private var conversionLabel: UILabel!
    @IBOutlet private var encodeSwitch: UISwitch!

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "URL Encode / Decode"
        backgroundViews.forEach {
            $0.layer.cornerRadius = Constant.defaultCornerRadius
        }
        inputTextView.delegate = self
        presenter.viewDidLoad()
    }

    // MARK: Other private methods

    private func encode(string: String) {
        let allowedCharacters = NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))
        if let encodedText = string.addingPercentEncoding(withAllowedCharacters: allowedCharacters) {
            outputTextView.text = encodedText
        }
    }

    private func decode(string: String) {
        if let decodedText = string.removingPercentEncoding {
            outputTextView.text = decodedText
        }
    }

    private func updateOutput() {
        if encodeSwitch.isOn {
            encode(string: inputTextView.text)
        }
        else {
            decode(string: inputTextView.text)
        }
    }

    @IBAction private func didEncodeSwitchValueChange(_ sender: UISwitch) {
        if sender.isOn {
            conversionLabel.text = "Encode"
        }
        else {
            conversionLabel.text = "Decode"
        }
        updateOutput()
    }

    @IBAction private func didPasteButtonPress(_ sender: Any) {
        if let text = UIPasteboard.general.string {
            inputTextView.text = text
            updateOutput()
            Drops.hideAll()
            Drops.show("Pasted!")
        }
    }

    @IBAction private func didCopyButtonPress(_ sender: Any) {
        if let text = outputTextView.text {
            UIPasteboard.general.string = text
            Drops.hideAll()
            Drops.show("Copied!")
        }
    }
}

extension URLEncodeDecodeViewController: URLEncodeDecodeViewInput {}

extension URLEncodeDecodeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateOutput()
    }
}
