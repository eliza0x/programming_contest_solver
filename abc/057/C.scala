object Main extends App {
  val n: Long = scala.io.StdIn.readLong()
  val digits = for { i<-Iterator.iterate(1l)(_ + 1l).takeWhile(_ <= math.sqrt(n))
        if n%i == 0 
      } yield math.max(i.toString.length, (n/i).toString.length)
  println(digits.toList.min)
}
