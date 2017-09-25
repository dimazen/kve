
import Foundation
import Stencil
import PathKit

struct OutputRenderer {
  struct Vars {
    static let name: String = "name"
    static let encodingKey: String = "encoding_key"
    static let encodedValues: String = "encoded_key_values"
  }

  var output: String
  var name: String
  var template: Template

  func render(_ encodingResult: EncodingResult) throws {
    let environment = Environment(loader: makeLoader(for: template))
    let renderedTemplate = try environment.renderTemplate(
      name: template.filename,
      context: [
        Vars.name: name,
        Vars.encodingKey: encodingResult.key,
        Vars.encodedValues: encodingResult.values
      ]
    )

    try renderedTemplate.write(to: URL(fileURLWithPath: output), atomically: true, encoding: .utf8)
  }

  // MARK: - Utility

  private func makeLoader(for template: Template) -> Loader {
    if case .custom(let value) = template {
      return FileSystemLoader(paths: [Path(value).parent()])
    } else {
      let bundlePath = Path(Bundle.main.bundlePath)
      let parentPath = bundlePath.parent()
      let searchPaths: [Path] = [
        bundlePath,
        bundlePath + "templates/",
        bundlePath + "resources/templates/",
        parentPath + "templates/",
        parentPath + "resources/templates/"
      ]

      return FileSystemLoader(paths: searchPaths)
    }
  }
}

