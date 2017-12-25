enum class State { A, B, C, D, E, F }
enum class Movement { LEFT, RIGHT}

data class Rule(
    val state: State,
    val current: Int,
    val write: Int,
    val move: Movement,
    val nextState: State
)

class TuringMachine(var state: State, val rules: List<Rule>) {
    val tape = HashMap<Int, Int>().withDefault { 0 }
    var cursor = 0

    fun execute() {
        val rule = rules.first { it.state == state && it.current == tape.getValue(cursor) }
        tape[cursor] = rule.write
        cursor += if (rule.move == Movement.RIGHT) 1 else -1
        state = rule.nextState
    }
}

fun main(args: Array<String>) {
    val rules = listOf(
        Rule(State.A, 0, 1, Movement.RIGHT, State.B),
        Rule(State.A, 1, 0, Movement.LEFT, State.F),
        Rule(State.B, 0, 0, Movement.RIGHT, State.C),
        Rule(State.B, 1, 0, Movement.RIGHT, State.D),
        Rule(State.C, 0, 1, Movement.LEFT, State.D),
        Rule(State.C, 1, 1, Movement.RIGHT, State.E),
        Rule(State.D, 0, 0, Movement.LEFT, State.E),
        Rule(State.D, 1, 0, Movement.LEFT, State.D),
        Rule(State.E, 0, 0, Movement.RIGHT, State.A),
        Rule(State.E, 1, 1, Movement.RIGHT, State.C),
        Rule(State.F, 0, 1, Movement.LEFT, State.A),
        Rule(State.F, 1, 1, Movement.RIGHT,State.A)
    )
    val tm = TuringMachine(State.A, rules)

    for (i in 1..12794428) {
        tm.execute()
    }

    val count = tm.tape.values.count { it == 1 }
    println(count)
}
