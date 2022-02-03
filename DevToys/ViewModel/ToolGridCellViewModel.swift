//
//  ToolGridCellViewModel.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit

final class ToolGridCellViewModel: Hashable {
    static func == (lhs: ToolGridCellViewModel, rhs: ToolGridCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(toolItem)
    }

    let toolItem: ToolItem

    init(toolItem: ToolItem) {
        self.toolItem = toolItem
    }

    var title: String? {
        return toolItem.content().text
    }

    var image: UIImage? {
        return toolItem.content().image
    }
}
