// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "SRTReader",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .library(
      name: "SRTReader",
      targets: ["SRTReader"]),
  ],
  targets: [
    .target(
      name: "SRTReader"),
    .testTarget(
      name: "SRTReaderTests",
      dependencies: ["SRTReader"],
      resources: [
        .copy("[Erai-raws] Hikikomari Kyuuketsuki no Monmon - 01.srt"),
        .copy("[Erai-raws] Hikikomari Kyuuketsuki no Monmon - 02.srt")
      ]
    ),
  ]
)
