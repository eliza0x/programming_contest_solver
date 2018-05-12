sealed trait Board
case object White   extends Board 
case object Black   extends Board 
case object Nothing extends Board 

object Main {
  def main(arg: Array[String]) {
    val scan = new java.util.Scanner(System.in)
    var board = Array.fill[Board](8, 8)(new Nothing)
    for ( i <- 0 until 8 ) {
      val b: String = scan.next()
      for ((c, j) <- b.zip(0 until 8)) {
        board(i)(j) = c match {
          case 'o' => new White
          case 'x' => new Black
          case '.' => new Nothing
        }
      }
    }
  }

  def do(board: Array[Array[Board]], myColor: Board): Array[Array[Board]] {
    var points = Array.fill(8, 8)(-1)
    for (y<-0 until 8; x<-0 until 8; if board(y)(x) == myColor) {
      for (i<-0 until 8; l<-0 until 8; if board(i)(l) == Nothing) {
        val ySub = y - i; val xSub = x - l
        if (ySub==xSub || ySub==0 || xSub==0) {
          val nextIter = if (ySub == xSub) { // 斜め
            (math.min(y,i) to math.max(y,i), math.min(x,l) to math.max(x,l))
          } else if (ySub == 0) { // 横
            (List.fill(8)(y), math.min(x,l) to math.max(x,l))
          } else if (xSub == 0) { // 縦
            (math.min(y,i) to math.max(y,i), List.fill(8)(x))
          }
        }
      }
    }
  }

}
