//
//  LineStickersService.swift
//  LineStickersKit
//
//  Created by devonly on 2022/04/13.
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//

import Foundation
import Alamofire
import Combine
import ZipArchive
import SwiftUI

final internal class LineStickersService: ObservableObject {
    private var cancellable: AnyCancellable?

    /// StickerType
    public enum StickerType: String, CaseIterable, Identifiable {
        public var id: String { rawValue }
        /// Line stickers.
        case sticker = "stickers@2x"
        /// Line stickers with APNG.
        case pack = "stickerpack@2x"
    }

    @Published var atPath: URL?

    init() {}

    init(productId: Int, bundleId: Int, withAnimation: Bool = false) {
        let productDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(productId)")
        let targetPath: URL = {
            if withAnimation {
                return productDirectory
                    .appendingPathComponent("popup")
                    .appendingPathComponent("\(bundleId)")
                    .appendingPathExtension("png")
            } else {
                return productDirectory
                    .appendingPathComponent("\(bundleId)@2x")
                    .appendingPathExtension("png")
            }
        }()
        if !FileManager.default.fileExists(atPath: targetPath.path) {
            downloadToDocuments(productId: productId, bundleId: bundleId, type: withAnimation ? .pack : .sticker)
        } else {
            self.atPath = targetPath
        }
    }

    private func download(productId: Int, type: StickerType) -> AnyPublisher<Data, AFError> {
        let url: URL = URL(string: "https://stickershop.line-scdn.net/stickershop/v1/product/\(productId)/iphone/\(type.rawValue).zip")!
        return AF.request(url)
            .publishData()
            .value()
    }

    private func downloadToDocuments(productId: Int, bundleId: Int, type: StickerType) {
        let documentDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filePath: URL = documentDirectory.appendingPathComponent("\(productId)").appendingPathExtension("zip")

        cancellable = download(productId: productId, type: type)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { response in
                let productDirectory: URL = documentDirectory.appendingPathComponent("\(productId)")
                try? response.write(to: filePath, options: .atomic)
                if SSZipArchive.unzipFile(atPath: filePath.path, toDestination: productDirectory.path) {
                    let targetPath: URL = {
                        switch type {
                        case .sticker:
                            return productDirectory
                                .appendingPathComponent("\(bundleId)@2x")
                                .appendingPathExtension("png")
                        case .pack:
                            return productDirectory
                                .appendingPathComponent("popup")
                                .appendingPathComponent("\(bundleId)")
                                .appendingPathExtension("png")
                        }
                    }()
                    self.atPath = targetPath
                } else {
                    print("Unzip failure.")
                }
            })
    }
}
