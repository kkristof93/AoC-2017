import Foundation

let path = "input.txt"
let fileContents = try! String(contentsOfFile: path, encoding: .utf8)

var nums = fileContents.components(separatedBy: "\t").map{ Int($0)! }
var cycles = [[Int]]()
var i = 0

while !cycles.contains(where: { $0 == nums }) {
    cycles.append(nums)

    let max = nums.max()!
    let start = nums.index(of: max)!

    nums[start] = 0
    for i in 1...max {
        nums[(start + i) % nums.count] += 1
    }

    i += 1
}

print(i)
