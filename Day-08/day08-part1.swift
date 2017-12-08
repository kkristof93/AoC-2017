import Foundation

class CPU {
    var registers = [String: Int]()

    subscript(key: String) -> Int {
        get {
            return registers[key] ?? 0
        }
        set(newValue) {
            registers[key] = newValue
        }
    }
}

enum Operation: String {
    case increase = "inc"
    case decrease = "dec"
}

enum Relation: String {
    case equals = "=="
    case notEquals = "!="
    case greaterThan = ">"
    case lessThan = "<"
    case greaterThanOrEquals = ">="
    case lessThanOrEquals = "<="
}

struct Condition {
    let register: String
    let relation: Relation
    let value: Int

    func applies(cpu: CPU) -> Bool {
        let a = cpu[register]
        let b = value

        switch relation {
        case .equals: return a == b
        case .notEquals: return a != b
        case .greaterThan: return a > b
        case .lessThan: return a < b
        case .greaterThanOrEquals: return a >= b
        case .lessThanOrEquals: return a <= b
        }
    }
}

struct Instruction {
    let register: String
    let operation: Operation
    let value: Int
    let condition: Condition

    init(string: String) {
        let parts = string.components(separatedBy: " ")
        register = parts[0]
        operation = Operation(rawValue: parts[1])!
        value = Int(parts[2])!
        condition = Condition(register: parts[4], relation: Relation(rawValue: parts[5])!, value: Int(parts[6])!)
    }

    func apply(cpu: CPU) {
        if condition.applies(cpu: cpu) {
            switch operation {
            case .increase: cpu[register] = cpu[register] + value
            case .decrease: cpu[register] = cpu[register] - value
            }
        }
    }
}

let file = try! String(contentsOfFile: "input.txt", encoding: .utf8)
let lines = file.components(separatedBy: "\n")

var cpu = CPU()

for line in lines {
    let instruction = Instruction(string: line)
    instruction.apply(cpu: cpu)
}

print(cpu.registers.values.max()!)
