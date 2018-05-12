object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n, m = scan.next().toInt
  val ps = (1 to n).toList.map(i => (i,scan.next().toInt))
  
  val unionFind = Array.fill(n+1)(0)
  for (i <- 0 to n) unionFind(i) = i
  for (_ <- 1 to m) {
    val x, y = scan.next().toInt
    union(x, y)
  }

  var cnt = 0
  for ((i,p) <- ps)
    cnt += (if (find(i) == find(p)) {1} else {0})

  println(cnt)

  def find(i: Int): Int = {
    if (unionFind(i) == i) i
    else {
      val r = find(unionFind(i))
      unionFind(i) = r
      r
    }
  }

  def union(i: Int, l: Int): Unit = {
    val iRoot = find(i)
    val lRoot = find(l)
    unionFind(iRoot) = math.min(iRoot, lRoot)
    unionFind(lRoot) = math.min(iRoot, lRoot)
  }
}
