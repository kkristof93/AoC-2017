import Foundation

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lengths = file.components(separatedBy: ",").map{ Int($0)! }

var list = Array(0...255)

func knotHash(input: [Int], lengths: [Int]) -> [Int] {
    var list = input.map{ $0 }
    let m = list.count
    var position = 0
    var skipSize = 0

    for length in lengths {
        for i in 0..<(length / 2) {
            let temp = list[(position + i) % m]
            list[(position + i) % m] = list[(position + length - i - 1) % m]
            list[(position + length - i - 1) % m] = temp
        }
        position += length + skipSize
        skipSize += 1
    }

    return list
}

let hashed = knotHash(input: list, lengths: lengths)
print(hashed[0] * hashed[1])
