// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "OnRemoveFromParent",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "OnRemoveFromParent",
      targets: [
        "OnRemoveFromParent",
      ]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.2.2"),
  ],
  targets: [
    .target(
      name: "OnRemoveFromParent",
      dependencies: [
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
      ]
    ),
    .testTarget(
      name: "OnRemoveFromParentTests",
      dependencies: [
        "OnRemoveFromParent",
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
