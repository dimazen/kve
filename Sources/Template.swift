
import Foundation
import PathKit

enum Template {
  enum BuiltIn: String {
    case swiftStruct = "swift-struct"
    case swiftEnum = "swift-enum"
  }

  case builtIn(BuiltIn)
  case custom(String)

  init(_ rawValue: String) {
    if let value = BuiltIn(rawValue: rawValue) {
      self = .builtIn(value)
    } else {
      self = .custom(rawValue)
    }
  }

  var filename: String {
    switch self {
    case .builtIn(let value):
      return "\(value.rawValue).stencil"

    case .custom(let value):
      return Path(value).lastComponent
    }
  }
}
