object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n    = scan.next().toInt
  val ns   = (1 to n*3).map(_ => scan.next().toLong).toArray

  val p    = collection.mutable.PriorityQueue[Long]()(Ordering.Long.reverse);
  val f    = Array.fill(n+1)(0L)
  var fsum = 0L
  for (i <- 0 until n) {
    p    += ns(i)
    fsum += ns(i)
  }
  f(0) = fsum
  for (i <- (0+n) until (n+n)) {
    p      += ns(i)
    fsum   += ns(i)
    fsum   -= p.dequeue
    f(i-n+1)  = fsum
  }

  val q = collection.mutable.PriorityQueue[Long]();
  val r = Array.fill(n+1)(0L)
  var rsum = 0L
  for (i <- (3*n-1) to (2*n) by -1) {
    q    += ns(i)
    rsum += ns(i)
  }
  r(n) = rsum
  for (i <- (2*n-1) to n by -1) {
    q      += ns(i)
    rsum   += ns(i)
    rsum   -= q.dequeue
    r(i-n)  = rsum
  }

  println(f.zip(r).toList.map(t => t._1 - t._2).max)
}
