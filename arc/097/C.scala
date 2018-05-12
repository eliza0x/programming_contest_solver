object Main extends App {
  var li = scala.collection.mutable.Set[String]()
  val s = scala.io.StdIn.readLine()
  val n = scala.io.StdIn.readLine().toInt
  for (i <- 0 to s.length) {
    for (l <- i to math.min(i+5, s.length)) {
      li += s.slice(i,l)
    }
  }
  println(li.toList.sorted.drop(1)(n-1))
}
