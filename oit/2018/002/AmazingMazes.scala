import scala.collection.mutable.Queue

object Main {
  val scan = new java.util.Scanner(System.in)
  def main(args: Array[String]) {
    val width  = scan.next().toInt
    val height = scan.next().toInt
    if (width != 0 || height != 0) {
      solve(width, height)
      main(args)
    }
  } 

  def solve(width: Int, height: Int) {
    var memo: Array[Array[Int]] = Array.fill(height*2-1, width*2-1)(100000000)
    memo(0)(0) = 0
    for ( i <- 0 until (height*2-1) by 2 ) {
      for ( j <- 0 until (width-1) ) memo(i)(j*2+1) = scan.next().toInt * -1
      if (i+1 < height*2-1) 
        for ( j <- 0 until width     ) memo(i+1)(j*2) = scan.next().toInt * -1
    }

    val q: Queue[(Int, Int)] = new Queue()
    q += ((0,0))
    while (!q.isEmpty) {
      val (cy, cx): (Int, Int) = q.dequeue
      val l: List[(Int, Int)] = List((-1, 0), (1, 0), (0, 1), (0, -1)) 
      for ( (i, j) <- l ) {
        val (nby, nbx) = (i+cy, j+cx)
        val (ny, nx) = (i+i+cy, j+j+cx)
        if (0<=ny && ny<(height*2-1) && 0<=nx && nx<(width*2-1) && memo(nby)(nbx) != -1) {
          if (memo(ny)(nx) > memo(cy)(cx) + 1) {
            memo(ny)(nx) = math.min(memo(ny)(nx), memo(cy)(cx) + 1)
            q += ((ny, nx))
          }
        }
      }
    }
    
    println(List(memo(height*2-2)(width*2-2)).map(x => if (x == 100000000) {0} else {x+1}).head)
  }
}
