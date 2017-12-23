import java.io.File
import java.io.InputStream

fun main(args: Array<String>) {
    val instructions = mutableListOf<String>()
    val registers = HashMap<String, Int>()

    fun getValue(arg: String): Int {
        val intVal = arg.toIntOrNull()
        if (intVal != null) {
            return intVal
        }
        return registers[arg] ?: 0
    }

    val inputStream: InputStream = File("input.txt").inputStream()
    inputStream.bufferedReader().useLines { lines -> lines.forEach {
        instructions.add(it)
    } }

    var pc = 0
    var count = 0
    loop@ while (pc < instructions.size) {
        val items = instructions[pc].split(" ")
        when (items[0]) {
            "set" -> registers[items[1]] = getValue(items[2])
            "sub" -> registers[items[1]] = getValue(items[1]) - getValue(items[2])
            "mul" -> {
                registers[items[1]] = getValue(items[1]) * getValue(items[2])
                count++
            }
            "jnz" -> {
                if (getValue(items[1]) != 0) {
                    pc += getValue(items[2])
                    continue@loop
                }
            }
        }

        pc++
    }

    println(count)
}
