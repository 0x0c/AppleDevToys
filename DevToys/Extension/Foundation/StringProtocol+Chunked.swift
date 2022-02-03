//
//  StringProtocol+Chunked.swift
//  DevToys
//
//  Created by Akira Matsuda on 2022/02/03.
//

import Foundation

// https://forums.swift.org/t/chunking-collections-and-strings-in-swift-5-1/26524
extension StringProtocol {
    func chunked(into size: Int) -> [SubSequence] {
        var chunks: [SubSequence] = []
        var idx = startIndex
        while let nextIndex = index(idx, offsetBy: size, limitedBy: endIndex) {
            chunks.append(self[idx ..< nextIndex])
            idx = nextIndex
        }

        let finalChunk = self[idx ..< endIndex]
        if finalChunk.isEmpty == false {
            chunks.append(finalChunk)
        }

        return chunks
    }
}
