// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "swift-ui-on-remove-from-parent",
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
  targets: [
    .target(
      name: "SUIOnRemoveFromParent"
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
