//
//  ToolItem.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import UIKit

enum ToolItem: Hashable, CaseIterable {
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
        var detail: String?
        var image: UIImage?
    }

    func content() -> Content {
        switch self {
        case .allTools:
            return .init(
                text: "All tools",
                image: UIImage(systemSymbol: .house)
            )
        case .jsonYamlConvert:
            return .init(
                text: "Json <> Yaml",
                detail: "Convert Json data to Yaml data and vice versa",
                image: UIImage(systemSymbol: .arrowLeftArrowRightSquare)
            )
        case .numberBase:
            return .init(
                text: "Number Base",
                detail: "Convert numbers from one base to another",
                image: UIImage(systemSymbol: ._42Square)
            )
        case .htmlEncodeDecode:
            return .init(
                text: "HTML",
                detail: "Encode or decode all the applicable characters to their corresponding HTML",
                image: UIImage(systemSymbol: .chevronLeftSlashChevronRight)
            )
        case .urlEncodeDecode:
            return .init(
                text: "URL",
                detail: "Encode or decode all the applicable characters to their corresponding URL",
                image: UIImage(systemSymbol: .link)
            )
        case .base64EncodeDecode:
            return .init(
                text: "Base64",
                detail: "Encode and decode Base 64 data",
                image: UIImage(systemSymbol: ._46Circle)
            )
        case .jwtDecoder:
            return .init(
                text: "JWT Decoder",
                detail: "Decode a JWT header payload and signature",
                image: UIImage(systemSymbol: .rays)
            )
        case .jsonFormatter:
            return .init(
                text: "Json Formatter",
                detail: "Indent or minify Json data",
                image: UIImage(systemSymbol: .curlybraces)
            )
        case .hashGenerator:
            return .init(
                text: "Hash",
                detail: "Calculate MD5, SHA1, SHA256 and SHA512 hash from text data",
                image: UIImage(systemSymbol: .numberSquare)
            )
        case .uuidGenerator:
            return .init(
                text: "UUID",
                detail: "Generate UUIDs version 1 and 4",
                image: UIImage(systemSymbol: .key)
            )
        case .loremIpsumGenerator:
            return .init(
                text: "Lorem Ipsum",
                detail: "Generate Lorem Ipsum placeholder text",
                image: UIImage(systemSymbol: .docText)
            )
        case .inspectorCaseConverter:
            return .init(
                text: "Inspector & Case Converter",
                detail: "Analyze text and convert it to different case",
                image: UIImage(systemSymbol: .textformat)
            )
        }
    }
}
