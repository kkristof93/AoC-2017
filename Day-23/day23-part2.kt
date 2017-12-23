fun isNotPrime(n: Int): Boolean {
    for (i in 2..(n / 2)) {
        if (n % i == 0) {
            return true
        }
    } 
    return false
}

fun main(args: Array<String>) {
    var b = 106700
    var c = 123700
    var h = 0
    
    for (i in b..c step 17) {
        if (isNotPrime(i)) {
            h++
        }
    }

    println(h)
}
