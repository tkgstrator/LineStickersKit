//
//  LineSticker.swift
//  LineStickersKit
//
//  Created by devonly on 2022/04/13.
//  Copyright © 2022 Magi, Corporation. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

public struct LineSticker: View {
    @StateObject var service: LineStickersService

    /// Initialize with APNG
    public init(productId: Int, bundleId: Int, withAnimation: Bool = false) {
        self._service = StateObject(wrappedValue: LineStickersService(productId: productId, bundleId: bundleId, withAnimation: withAnimation))
    }

    /// Initialize with PNG
    public init(productId: Int, bundleId: Int) {
        self._service = StateObject(wrappedValue: LineStickersService(productId: productId, bundleId: bundleId))
    }

    public var body: some View {
        WebImage(url: service.atPath)
            .resizable()
            .scaledToFit()
    }
}
