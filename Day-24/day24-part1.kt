import java.io.File
import java.io.InputStream

fun build(ports: List<Pair<Int, Int>>, last: Int = 0, strength: Int = 0): Int {
    return ports.filter { it.first == last || it.second == last }
        .map { 
            val newLast = if (last == it.first) it.second else it.first
            build(ports.minusElement(it), newLast, strength + it.first + it.second)
        }
        .plus(strength)
        .max()!!
}

fun main(args: Array<String>) {
    val ports = mutableListOf<Pair<Int, Int>>()

    val inputStream: InputStream = File("input.txt").inputStream()
    inputStream.bufferedReader().useLines { lines -> lines.forEach {
        val items = it.split("/")
        ports.add(Pair(items[0].toInt(), items[1].toInt()))
    } }

    println(build(ports))
}
