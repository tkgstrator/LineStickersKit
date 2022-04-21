# LineStickersKit

LineStickersKit is the library of downloading stickers(as `zip`) from an official server and view with animation for SwiftUI.

## Requirements

- Xcode12
- iOS14+
- macOS11+

## Installation

### Swift Package Manager

LineStickersKit is available through Swift Package Manager.

```swift
.package(url: "https://github.com/tkgstrator/LineStickersKit.git", from: "1.0.0")
```

## Usage

### ProductId

- Open LINE Store website at [store.line.me](https://store.line.me/)
- [Find stickers](https://store.line.me/search/en?q=splatoon) that you want by keywords
- Click the sticker image
- Look at the [URLaddress](https://store.line.me/stickershop/product/6701/en)

If you find `https://store.line.me/stickershop/product/6701/en`, then productId is exactlly `6701`.

### BundleId

For regular stickers, the download link is `https://stickershop.line-scdn.net/stickershop/v1/product/[ProductId]/iphone/stickers@2x.zip`. Replace **ProductId** that you want.

Other stickers(like with animation, sound), it is `https://stickershop.line-scdn.net/stickershop/v1/product/[ProductId]/
iphone/stickerpack@2x.zip`

Download the sticker compress file, and extract it, then you can find the image files in such a directory path.

```
6701
  popup/ (APNG)
    *BundleId*.png
  sound/ (M4A)
  productInfo.meta
```

check the **BundleId** of the file you want.

### View

```swift
import SwiftUI
import LineStickersKit

struct ContentView: View {
    var body: some View {
        LineSticker(productId: 6701, bundleId: 11921510, withAnimation: true)
    }
}
```
