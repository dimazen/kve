
import Foundation

enum BuiltInError: Error, CustomStringConvertible {
  case argumentFileNotFound(String, String)
  case argumentNotAFile(String, String)

  var description: String {
    switch self {
    case .argumentFileNotFound(let argument, let path):
      return "<\(argument)> not found at path: \(path)."

    case .argumentNotAFile(let argument, let path):
      return "<\(argument)> doesn't look like a file: \(path)."
    }
  }
}
