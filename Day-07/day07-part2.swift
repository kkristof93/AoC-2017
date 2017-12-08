import Foundation

class Program {
    let name: String
    let weight: Int
    var children: [String]
    var parent: Program?
    
    init(name: String, weight: Int, children: [String]) {
        self.name = name
        self.weight = weight
        self.children = children
    }
}

var programs = [String : Program]()

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = file.components(separatedBy: "\n")

for line in lines {
    var nameAndWeight: String
    var children: [String]

    if line.contains(" -> ") {
        let items = line.components(separatedBy: " -> ")
        nameAndWeight = items[0]
        children = items[1].components(separatedBy: ", ")
    } else {
        nameAndWeight = line
        children = []
    }

    let name = String(nameAndWeight[..<nameAndWeight.index(of: " ")!])
    let startIndex = nameAndWeight.index(after: nameAndWeight.index(of: "(")!)
    let endIndex = nameAndWeight.index(of: ")")!
    let weight = Int(nameAndWeight[startIndex..<endIndex])!

    let program = Program(name: name, weight: weight, children: children)
    programs[name] = program
}

for (name, program) in programs {
    program.parent = programs.values.first { $0.children.contains(name) }
}

let root = programs.values.first { $0.parent == nil }!

func sumWeight(_ p: Program, foundCorrect: inout Int?) -> Int {
    var found: Int?
    let childrenWeight = p.children.map{ sumWeight(programs[$0]!, foundCorrect: &found) }

    if found == nil {
        var counts = [Int: Int]()
        childrenWeight.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
        
        if counts.count > 1 {
            let correctSum = counts.first(where: { $0.value != 1 })!.key
            let wrongSum = counts.first(where: { $0.value == 1 })!.key
            let wrongChildIndex = childrenWeight.index(where: { $0 != correctSum })!
            let wrongChild = programs[p.children[wrongChildIndex]]!

            foundCorrect = wrongChild.weight - (wrongSum - correctSum)
        }
    } else {
        foundCorrect = found
    }
    
    return p.weight + childrenWeight.reduce(0, +)
}

var correct: Int?
_ = sumWeight(root, foundCorrect: &correct)
print(correct!)
