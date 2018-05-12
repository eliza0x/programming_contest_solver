object Main extends App {
  val n = io.StdIn.readLine().toInt
  val numbers = Array.fill(20000)(true)
  for ( i <- 2 until numbers.length/2 )
    numbers(2*i) = false
  for ( i <- 3 until numbers.length )
    for ( l <- 3 until numbers.length by 2; if i*l < numbers.length )
      numbers(i*l) = false
  val primes = (0 to numbers.length).zip(numbers).filter(_._2).map(_._1).drop(2).filter(_ % 5 == 1)
  for ( i <- primes.take(n) ) print(i.toString ++ " ")
  println("")
}
