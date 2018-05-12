object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n = scan.next().toInt
  val a = scan.next().toDouble
  val xs = (1 to n).toArray.map(_ => scan.next().toInt)
  val memo = Array.fill(n+1, n+1,2501)(-1L)
  memo(0)(0)(0) = 1L
  for (i<-1 to n; j<-0 to n; k<-0 to 2500) {
    if (memo(i-1)(j)(k) != -1) { 
      if (memo(i)(j)(k) == -1) memo(i)(j)(k) = 0L
      memo(i)(j)(k) = memo(i-1)(j)(k)
    }
    if ((k-xs(i-1)>=0 && j-1>=0 && memo(i-1)(j-1)(k-xs(i-1)) != -1)) {
      if (memo(i)(j)(k) == -1) memo(i)(j)(k) = 0L
      memo(i)(j)(k) += memo(i-1)(j-1)(k-xs(i-1))
    } 
  }

  val ans = (for (j<-1 to n; k<-0 to 2500; if memo(n)(j)(k) != -1 && k%j==0 && k/j==a) 
            yield memo(n)(j)(k)).foldRight(0L)((x,s)=>x+s)
  println(ans)
}
