//
//  ToolGridCell.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit
import Reusable

class ToolGridCell: UICollectionViewCell, NibReusable {
    static let defaultSize = CGSize(width: 214, height: 358)

    @IBOutlet private var imageBaseView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!

    var viewModel: ToolGridCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            titleLabel.text = viewModel.title
            imageView.image = viewModel.image
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        imageBaseView.layer.cornerRadius = Constant.defaultCornerRadius
        layer.cornerRadius = Constant.defaultCornerRadius
    }
}
