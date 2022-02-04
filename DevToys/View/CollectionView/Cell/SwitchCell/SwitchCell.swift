//
//  SwitchCell.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Combine
import Reusable
import UIKit

class SwitchCell: UICollectionViewCell, NibReusable {
    static let defaultHeight: CGFloat = 44

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var enabledSwitch: UISwitch!
    private var cancellable = Set<AnyCancellable>()
    private var isUpdating = false

    var viewModel: SwitchCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.title
            iconImageView.image = viewModel.image
            iconImageView.isHidden = viewModel.image == nil
            enabledSwitch.isOn = viewModel.isOn
            viewModel.$isOn.removeDuplicates().sink { [weak self] enabled in
                guard let weakSelf = self else {
                    return
                }
                if weakSelf.isUpdating == false {
                    weakSelf.enabledSwitch.isOn = enabled
                }
            }.store(in: &cancellable)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = Constant.defaultCornerRadius
    }

    @IBAction private func didValueChange(_ sender: UISwitch) {
        guard let viewModel = viewModel else {
            return
        }
        defer {
            isUpdating = false
        }
        isUpdating = true
        viewModel.isOn = sender.isOn
    }
}
