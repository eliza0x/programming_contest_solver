object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val w = scan.next().toInt
  val n = scan.next().toInt
  val k = scan.next().toInt
  val ns = for ( _ <- (1 to n).toArray ) 
    yield (scan.next().toInt, scan.next().toInt)

  val dp = Array.fill(k+1, w+1, n+1)(0)
  for (ki <- 1 to k) {
    for (wi <- 1 to w) {
      for (i <- 1 to n) {
        val (width, value) = ns(i-1)
        dp(ki)(wi)(i) = math.max(dp(ki)(wi)(i), dp(ki)(wi)(i-1))
        dp(ki)(wi)(i) = math.max(dp(ki)(wi)(i), dp(ki)(wi-1)(i))
        dp(ki)(wi)(i) = math.max(dp(ki)(wi)(i), dp(ki-1)(wi)(i))
        if (wi-width >= 0)
          dp(ki)(wi)(i) = math.max(dp(ki)(wi)(i), dp(ki-1)(wi-width)(i-1) + value)
      }
    }
  }
  println(dp(k)(w)(n))
}
