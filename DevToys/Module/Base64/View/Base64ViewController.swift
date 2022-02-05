//
//  Base64ViewController.swift
//  DevToys
//
//  Created by Akira on 04/02/2022.
//  Copyright © 2022 Akira Matsuda. All rights reserved.
//

import UIKit

protocol Base64ViewInput: AnyObject {
    // MARK: Callback from presenter
}

final class Base64ViewController: UIViewController {
    // MARK: Stored instance properties

    var presenter: Base64PresenterInput!

    // MARK: Computed instance properties

    // MARK: IBOutlets

    @IBOutlet private var backgroundViews: [UIView]!
    @IBOutlet private var encodedTextView: UITextView!
    @IBOutlet private var decodedTextView: UITextView!

    // MARK: View Life-Cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Base64 Encode / Decode"
        backgroundViews.forEach {
            $0.layer.cornerRadius = Constant.defaultCornerRadius
        }
        encodedTextView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        decodedTextView.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        encodedTextView.delegate = self
        decodedTextView.delegate = self
        presenter.viewDidLoad()
    }

    // MARK: Other private methods
}

extension Base64ViewController: Base64ViewInput {}

extension Base64ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if encodedTextView == textView {
            decodedTextView.text = encodedTextView.text.data(using: .utf8)?.base64EncodedString()
        }
        else if decodedTextView == textView {
            if let data = Data(base64Encoded: decodedTextView.text) {
                encodedTextView.text = String(data: data, encoding: .utf8)
            }
            else {
                encodedTextView.text = ""
            }
        }
    }
}
