// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "SUIOnRemoveFromParent",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "SUIOnRemoveFromParent",
      targets: [
        "SUIOnRemoveFromParent",
      ]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "1.2.2"),
  ],
  targets: [
    .target(
      name: "SUIOnRemoveFromParent",
      dependencies: [
        .product(name: "IssueReporting", package: "xctest-dynamic-overlay"),
      ]
    ),
    .testTarget(
      name: "SUIOnRemoveFromParentTests",
      dependencies: [
        "SUIOnRemoveFromParent",
      ]
    ),
  ],
  swiftLanguageModes: [.v5]
)

for target in package.targets {
  var swiftSettings = target.swiftSettings ?? []
  swiftSettings.append(
    contentsOf: [
      .enableExperimentalFeature("StrictConcurrency")
    ]
  )
  target.swiftSettings = swiftSettings
}
