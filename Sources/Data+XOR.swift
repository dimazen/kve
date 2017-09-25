
import Foundation

extension Data {
    func xored(by key: Data) -> Data {
        var copy = self

        var keyIndex = 0
        for index in 0..<count {
            copy[index] ^= key[keyIndex]

            keyIndex += 1

            if keyIndex == key.count {
                keyIndex = 0
            }
        }

        return copy
    }
}
