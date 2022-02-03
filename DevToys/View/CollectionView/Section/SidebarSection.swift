//
//  SidebarSection.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import CompositionalLayoutViewController
import Reusable
import UIKit

class SidebarSection: ListSection<SidebarItem> {
    let headerTitle: String?

    var header: SidebarItem? {
        guard let headerTitle = headerTitle else {
            return nil
        }
        return .header(headerTitle)
    }

    init(items: [ToolItem], headerTitle: String? = nil) {
        self.headerTitle = headerTitle
        super.init(
            items: items.map { SidebarItem.toolItem($0) },
            cellCongicuration: { cell, _, item in
                var content = cell.defaultContentConfiguration()
                switch item {
                case let .header(title):
                    content.text = title
                    cell.accessories = [.outlineDisclosure()]
                case let .toolItem(item):
                    let cellContent = item.content()
                    content.image = cellContent.image
                    content.text = cellContent.text
                    cell.accessories = []
                }

                return content
            },
            appearance: .sidebar,
            headerMode: headerTitle != nil ? .firstItemInSection : .none
        )
    }

    override func item(for indexPath: IndexPath) -> SidebarItem {
        if let header = header {
            if indexPath.row == 0 {
                return header
            }
            return items[indexPath.row - 1]
        }
        return items[indexPath.row]
    }
}
