import Foundation

let stream = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let characters = Array(stream)

var depth = 0
var sum = 0
var inGarbage = false
var i = 0

while i < characters.count {
    let c = characters[i]

    switch c {
    case "!":
        i += 2
        continue
    case "<":
        inGarbage = true
    case ">":
        inGarbage = false
    case "{":
        if !inGarbage {
            depth += 1
            sum += depth
        }
    case "}":
        if !inGarbage {
            depth -= 1
        }
    default:
        break
    }

    i += 1
}

print(sum)
