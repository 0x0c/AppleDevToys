//
//  PulldownMenuCell.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/04.
//

import Combine
import Reusable
import UIKit

class PulldownMenuCell: UICollectionViewCell, NibReusable {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var pulldownButton: UIButton!
    private var cancellable = Set<AnyCancellable>()

    var viewModel: PulldownMenuViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.title
            detailLabel.text = viewModel.detail
            iconImageView.image = viewModel.iconImage
            pulldownButton.menu = UIMenu(
                title: "Input type",
                children: viewModel.menuTitles().map { title in
                    UIAction(title: title) { [unowned self] action in
                        self.didButtonPress(action.title)
                    }
                }
            )
            pulldownButton.showsMenuAsPrimaryAction = true
            pulldownButton.setTitle(viewModel.selectedItemTitle(), for: .normal)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = Constant.defaultCornerRadius
    }

    private func didButtonPress(_ title: String?) {
        guard let viewModel = viewModel else {
            return
        }
        pulldownButton.setTitle(title, for: .normal)
        pulldownButton.menu = UIMenu(
            title: "Input type",
            children: viewModel.menuTitles().map { title in
                UIAction(title: title) { [unowned self] action in
                    self.didButtonPress(action.title)
                }
            }
        )
        viewModel.updateMenu(for: title)
    }
}
