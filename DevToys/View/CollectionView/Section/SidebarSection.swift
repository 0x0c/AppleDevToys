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
    init(items: [SidebarItem]) {
        var showHeader: Bool {
            if case .header = items.first {
                return true
            }
            return false
        }
        super.init(
            items: items,
            cellCongicuration: { cell, _, item in
                var content = cell.defaultContentConfiguration()
                let cellContent = item.content()
                content.image = cellContent.image
                content.text = cellContent.text
                if case .header = item {
                    cell.accessories = [.outlineDisclosure()]
                }
                return content
            },
            appearance: .sidebar,
            headerMode: showHeader ? .firstItemInSection : .none
        )
    }
}
