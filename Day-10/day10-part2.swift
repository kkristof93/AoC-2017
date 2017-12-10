import Foundation

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lengths = Array(file).map{ UInt8(UnicodeScalar(String($0))!.value) } + [17, 31, 73, 47, 23]

func knotHash(lengths: [UInt8]) -> [UInt8] {
    var list = Array<UInt8>(0...255)
    var position = 0
    var skipSize = 0

    for _ in 0..<64 {
        for length in lengths {
            for i in 0..<(length / 2) {
                let temp = list[(position + Int(i)) % 256]
                list[(position + Int(i)) % 256] = list[(position + Int(length) - Int(i) - 1) % 256]
                list[(position + Int(length) - Int(i) - 1) % 256] = temp
            }
            position += Int(length) + skipSize
            skipSize += 1
        }
    }
    
    var dense = [UInt8]()

    for i in 0..<16 {
        var value = list[i * 16]
        for j in 1..<16 {
            value ^= list[i * 16 + j]
        }
        dense.append(value)
    }
    
    return dense
}

let hashed = knotHash(lengths: lengths)
let output = hashed.map{ String(format:"%2x", $0) }.joined()

print(output)
