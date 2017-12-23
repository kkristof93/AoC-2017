import java.io.File
import java.io.InputStream

data class Point(var x: Int, var y: Int) {
    fun add(p: Point) = Point(x + p.x, y + p.y)
    fun rotateRight() = Point(y, -x)
    fun rotateLeft() = Point(-y, x)
    fun reverse() = Point(-x, -y)
}

fun main(args: Array<String>) {
    val map = HashMap<Point, Char>()

    var i = 0
    val inputStream: InputStream = File("input.txt").inputStream()
    inputStream.bufferedReader().useLines { lines -> lines.forEach {
        for (j in 0 until it.length) {
            map[Point(i, j)] = it.get(j)
        }
        i++
    } }

    var pos = Point(i / 2, i / 2)
    var dir = Point(-1, 0)
    var count = 0

    for (burst in 0 until 10000000) {
        when(map[pos] ?: '.') {
            '.' -> {
                dir = dir.rotateLeft()
                map[pos] = 'W'
            }
            'W' -> {
                map[pos] = '#'
                count++
            }
            '#' -> {
                dir = dir.rotateRight()
                map[pos] = 'F'
            }
            'F' -> {
                dir = dir.reverse()
                map[pos] = '.'
            }
        }

        pos = pos.add(dir)
    }

    println(count)
}
