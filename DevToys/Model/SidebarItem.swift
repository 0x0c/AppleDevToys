//
//  SidebarItem.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit

enum SidebarItem: Hashable {
    case header(String)

    case allTools

    // Converters
    case jsonYamlConvert
    case numberBase

    // Encoders/ Decoders
    case htmlEncodeDecode
    case urlEncodeDecode
    case base64EncodeDecode
    // case gzipEncodeDecode
    case jwtDecoder

    // Formatters
    case jsonFormatter
    // case sqlFormatter
    // case xmlFormatter

    // Generator
    case hashGenerator
    case uuidGenerator
    case loremIpsumGenerator
    // case checkSumGenerator

    // Text
    case inspectorCaseConverter

    // Graphic

    struct Content {
        let text: String?
        var image: UIImage?
    }

    func content() -> Content {
        switch self {
        case let .header(string):
            return .init(text: string)
        case .allTools:
            return .init(
                text: "All tools",
                image: UIImage(systemSymbol: .house)
            )
        case .jsonYamlConvert:
            return .init(
                text: "JSON <> YAML",
                image: UIImage(systemSymbol: .arrowLeftArrowRightSquare)
            )
        case .numberBase:
            return .init(
                text: "Number Base",
                image: UIImage(systemSymbol: ._42Square)
            )
        case .htmlEncodeDecode:
            return .init(
                text: "HTML",
                image: UIImage(systemSymbol: .chevronLeftSlashChevronRight)
            )
        case .urlEncodeDecode:
            return .init(
                text: "URL",
                image: UIImage(systemSymbol: .link)
            )
        case .base64EncodeDecode:
            return .init(
                text: "Base64",
                image: UIImage(systemSymbol: ._46Circle)
            )
        case .jwtDecoder:
            return .init(
                text: "JWT",
                image: UIImage(systemSymbol: .rays)
            )
        case .jsonFormatter:
            return .init(
                text: "JSON",
                image: UIImage(systemSymbol: .curlybraces)
            )
        case .hashGenerator:
            return .init(
                text: "Hash",
                image: UIImage(systemSymbol: .numberSquare)
            )
        case .uuidGenerator:
            return .init(
                text: "UUID",
                image: UIImage(systemSymbol: .key)
            )
        case .loremIpsumGenerator:
            return .init(
                text: "Lorem Ipsum",
                image: UIImage(systemSymbol: .docText)
            )
        case .inspectorCaseConverter:
            return .init(
                text: "Inspector & Case Converter",
                image: UIImage(systemSymbol: .textformat)
            )
        }
    }
}
