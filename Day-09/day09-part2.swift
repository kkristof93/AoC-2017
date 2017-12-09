import Foundation

let stream = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let characters = Array(stream)

var garbageSum = 0
var inGarbage = false
var i = 0

while i < characters.count {
    let c = characters[i]

    switch c {
    case "!":
        i += 2
        continue
    case "<":
        if !inGarbage {
            inGarbage = true
            i += 1
            continue
        }
    case ">":
        inGarbage = false
    default:
        break
    }

    if inGarbage {
        garbageSum += 1
    }

    i += 1
}

print(garbageSum)
