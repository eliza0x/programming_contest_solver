object Main extends App {
  val n = io.StdIn.readLine().toInt
  val numbers = Array.fill(20000)(true)
  for ( i <- 2 until numbers.length/2 )
    numbers(2*i) = false
  for ( i <- 3 until numbers.length )
    for ( l <- 3 until numbers.length by 2; if i*l < numbers.length )
      numbers(i*l) = false
  val primes = (0 to numbers.length).zip(numbers).filter(_._2).map(_._1).drop(2)

  var memo = Array.fill(1+primes.length, 20000)(-1)
  memo(0)(0) = 0
  for ( (i, n) <- (1 to primes.length).zip(primes) ) {
    for ( l <- 0 until 20000; if memo(i-1)(l) != -1 ) {
      memo(i)(l) = math.max(memo(i-1)(l), memo(i)(l))
      if (l+n < 20000) {
        memo(i)(l+n) = math.max(memo(i-1)(l)+1, memo(i)(l+n))
      }
    }
  }

  println(memo(primes.length)(n))
}

