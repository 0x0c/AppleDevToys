//
//  InputNumberTypePulldownMenuCell.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Combine
import Reusable
import UIKit

class InputNumberTypePulldownMenuCell: UICollectionViewCell, NibReusable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var pulldownButton: UIButton!
    private var cancellable = Set<AnyCancellable>()

    var viewModel: InputNumberTypeSelectionCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.title
            detailLabel.text = viewModel.detail
            iconImageView.image = viewModel.iconImage
            pulldownButton.menu = UIMenu(
                title: "Input type",
                children: viewModel.selectableItems.map { item in
                    UIAction(title: item.title()) { [unowned self] _ in
                        self.valueChanged(item)
                    }
                }
            )
            pulldownButton.showsMenuAsPrimaryAction = true
            viewModel.$selectedItem.sink { [weak self] value in
                guard let weakSelf = self else {
                    return
                }
                weakSelf.updateMenu(for: value)
            }.store(in: &cancellable)
            updateMenu(for: viewModel.selectedItem)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = Constant.defaultCornerRadius
    }

    private func valueChanged(_ value: InputNumberType) {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.selectedItem = value
    }

    private func updateMenu(for value: InputNumberType?) {
        guard let viewModel = viewModel, let value = value else {
            return
        }
        pulldownButton.setTitle(value.title(), for: .normal)
        pulldownButton.menu = UIMenu(
            title: "Input type",
            children: viewModel.selectableItems.map { item in
                UIAction(title: item.title()) { [unowned self] _ in
                    self.valueChanged(item)
                }
            }
        )
    }
}
