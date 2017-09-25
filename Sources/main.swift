
import Foundation
import Commander
import PathKit

let inArg = Argument<String>("input", description: "Absolute path to the .json file") { value in
  let path = Path(value)
  if !path.exists {
    throw BuiltInError.argumentFileNotFound("input", value)
  }

  if !path.isFile {
    throw BuiltInError.argumentNotAFile("input", value)
  }

  return value
}

let outArg = Argument<String>("output", description: "Absolute path to the .swift file.")
let keyOption = Option("key", UUID().uuidString, description: "Key used for the XORing. Default value is a random UUID.")
let templateOption = Option(
  "template",
  "swift-struct",
  description: "Template used for the keys generation. Available options are: swift-struct and swift-enum or an absolute path to the template (/Users/user/template.stencil)."
)

func process(rawInputPath: String, rawOutputPath: String, encodingKey: String, rawTemplate: String) throws {
  let outputPath = Path(rawOutputPath)
  guard outputPath.extension != nil else {
    throw BuiltInError.argumentNotAFile("ouput", rawOutputPath)
  }

  try outputPath.parent().mkpath()

  let result = try KeyValueEncoder.encode(contentsOf: URL(fileURLWithPath: rawInputPath), with: encodingKey)
  let name = outputPath.lastComponentWithoutExtension
  try OutputRenderer(output: rawOutputPath, name: name, template: Template(rawTemplate)).render(result)
}

command(inArg, outArg, keyOption, templateOption, process).run()

