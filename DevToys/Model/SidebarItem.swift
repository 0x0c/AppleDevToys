//
//  SidebarItem.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Foundation

enum SidebarItem: Hashable {
    case header(String)
    case toolItem(ToolItem)
}
