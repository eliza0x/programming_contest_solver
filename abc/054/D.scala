object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n = scan.next().toInt
  val ma = scan.next().toInt
  val mb = scan.next().toInt
  val ns = for ( _ <- (1 to n).toArray ) 
    yield (scan.next().toInt, scan.next().toInt, scan.next().toInt)
  val dp: Array[Array[Array[Option[Int]]]] = Array.fill(n+1, 400, 400)(None)
  dp(0)(0)(0) = Some(0)
  for ( i <- 1 to n ) {
    val (a, b, value) = ns(i-1)
    for ( j <- 0 until 400 ) {
      for ( k <- 0 until 400 ) {
        dp(i)(j)(k) = (dp(i-1)(j)(k), dp(i)(j)(k)) match {
          case (Some(n), Some(m)) => Some(math.min(n,m))
          case (Some(n), _)       => Some(n)
          case (_, Some(m))       => Some(m)
          case _                  => None
        }
        if (a+j<400 && b+k<400) {
          dp(i)(a+j)(b+k) = (dp(i-1)(j)(k), dp(i-1)(a+j)(b+k)) match {
            case (Some(n), Some(m)) => Some(math.min(n+value,m))
            case (Some(n), _)       => Some(n+value)
            case (_, Some(m))       => Some(m)
            case _                  => None
          }
        }
      }
    }
  }

  val costs = for (i <- 1 until 400; j <- 1 until 400;
    if ma*j == mb*i; if dp(n)(i)(j) != None) yield { dp(n)(i)(j).get }
          
  println(if (costs.nonEmpty) { costs.min } else { -1 })
}
