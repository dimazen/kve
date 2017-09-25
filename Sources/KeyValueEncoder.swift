
import Foundation

struct EncodingResult {
  var key: [UInt8]
  var values: [EncodedKeyValue]
}

struct EncodedKeyValue {
  var key: String
  var value: [UInt8]
}

struct KeyValueEncoder {
  static func encode(_ keyValues: [String: String], with key: String) -> EncodingResult {
    let encodingKeyData = key.data(using: .ascii)!
    
    let values: [EncodedKeyValue] = keyValues.map { (key, value) -> EncodedKeyValue in
      let encodedValueData = value.data(using: .ascii)?.xored(by: encodingKeyData)
      return EncodedKeyValue(key: key, value: encodedValueData.map { Array($0) } ?? [])
    }

    return EncodingResult(key: Array(encodingKeyData), values: values)
  }

  static func encode(contentsOf url: URL, with key: String) throws -> EncodingResult {
    let inputData = try Data(contentsOf: url)
    let keyValues = try JSONDecoder().decode([String: String].self, from: inputData)

    return encode(keyValues, with: key)
  }
}
