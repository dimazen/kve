import PackageDescription

let package = Package(
  name: "kve",
  targets: [
    Target(name: "kve", dependencies: [])
  ],
  dependencies: [
    .Package(url: "https://github.com/kylef/Stencil.git", majorVersion: 0, minor: 9),
    .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 6),
    .Package(url: "https://github.com/kylef/PathKit.git", majorVersion: 0, minor: 8)
  ]
)
