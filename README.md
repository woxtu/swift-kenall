# swift-kenall

[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg?style=flat-square)](https://github.com/apple/swift-package-manager)

A [Kenall (ケンオール)](https://kenall.jp/) API client for Swift.

For more information:

- https://kenall.jp/
- https://www.notion.so/f4f14e3fae7f4be2879b153f8127cea9

## Installation

### Swift Package Manager

```swift
.package(url: "https://github.com/woxtu/swift-kenall.git", from: "1.0.0")
```

## Usage

```swift
import Kenall

let client = KenallClient(apiKey: "<YOUR_API_KEY>")

client.address(postalCode: "1000001") { result in
    print(result)
}
```

## License

Copyright 2021 woxtu

Licensed under the MIT license.
