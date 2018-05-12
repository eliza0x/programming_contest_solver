object Main extends App {
	val scan = new java.util.Scanner(System.in)
	val n, k = scan.next().toInt
    val ns = (1 to n).toList.map(_ => (scan.next().toLong, scan.next().toLong))
                     .sortBy(_._1)
    println(rec(n,ns))

    def rec(n:Long, l: List[(Long, Long)]): Long =
      if (n-l.head._2 < 0) { l.head._1 } else { rec(n-l.head._2, l.tail) }
}
