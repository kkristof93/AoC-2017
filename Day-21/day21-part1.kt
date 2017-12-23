import java.io.File
import java.io.InputStream

fun rotate(mat: List<String>): List<String> {
    val len = mat.size
    val rot = Array(len) { arrayOfNulls<Char>(len) }

    for (i in 0 until len) {
        for (j in 0 until len) {
            rot[len - i - 1][j] = mat[j].get(i);
        }
    }

    return rot.map({ s -> s.joinToString("") })
}

fun flip(mat: List<String>): List<String> {
    val len = mat.size
    val rot = Array(len) { arrayOfNulls<Char>(len) }

    for (i in 0 until len) {
        for (j in 0 until len) {
            rot[i][j] = mat[i].get(len - j - 1)
        }
    }

    return rot.map({ s -> s.joinToString("") })
}

fun applyRule(rules: HashMap<String, String>, pattern: List<String>): List<String>? {
    val rot1 = rotate(pattern)
    val rot2 = rotate(rot1)
    val rot3 = rotate(rot2)
    val patterns = listOf(pattern, rot1, rot2, rot3, flip(pattern), flip(rot1), flip(rot2), flip(rot3))

    for (p in patterns) {
        val patternString = p.joinToString("/")
        if (rules.containsKey(patternString)) {
            return rules.get(patternString)?.split("/")
        }
    }
    return null
}

fun main(args: Array<String>) {
    val rules = HashMap<String, String>()

    val inputStream: InputStream = File("input.txt").inputStream()
    inputStream.bufferedReader().useLines { lines -> lines.forEach {
        val items = it.split(" => ")
        rules[items[0]] = items[1]
    } }
    
    var grid = arrayOf(".#.", "..#", "###")

    for (round in 0 until 5) {
        val size = grid.size
        val len = if(size % 2 == 0) 2 else 3
        val squares = size / len
        val newGrid = Array(squares * (len + 1)) { "" }

        for (i in 0 until squares) {
            for (j in 0 until squares) {
                val square = mutableListOf<String>()
                for (k in 0 until len) {
                    val row = grid[i * len + k]
                    val slice = row.substring(j * len, (j + 1) * len)
                    square.add(slice)
                }

                val applied = applyRule(rules, square)!!
                val newLen = applied.size

                for (k in 0 until newLen) {
                    newGrid[i * newLen + k] += applied[k]
                }
            }
        }
        grid = newGrid
    }

    println(grid.joinToString("/").count({c -> c == '#'}))
}
