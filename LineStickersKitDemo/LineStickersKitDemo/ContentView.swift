//
//  ContentView.swift
//  LineStickersKitDemo
//
//  Created by devonly on 2022/04/13.
//  
//

import SwiftUI
import LineStickersKit

struct ContentView: View {
    var body: some View {
        LineSticker(productId: 6701, bundleId: 11921510, withAnimation: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
