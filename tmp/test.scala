object Main extends App {
  import scala.io.StdIn.readLine
  val Array(turn, n): Array[Int] = readLine split(" ") map(_.toInt) 
  val obstacles: List[List[Int]] = for (_ <- (1 to n).toList) yield
    readLine split(" ") map(_.toInt) toList

  var floor: Array[Array[Int]] = Array.ofDim[Int](60, 60)
  for ( i <- 0 to 59; j <- 0 to 59 ) floor(i)(j) = -2
  for ( List(x, y) <- obstacles ) {
    floor(29+x)(29+y) = -1
  }
  floor(29)(29) = 0

  for ( k <- 1 to turn
      ; i <- 0 to 59
      ; j <- 0 to 59
      ) {
    // println("i: "++i.toString++", j: "++j.toString)
    if (0<i  &&         floor(i-1)(j  ) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i-1)(j  ) = k }
    if (0<i  && j<59 && floor(i-1)(j+1) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i-1)(j+1) = k }
    if (0<j          && floor(i  )(j-1) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i  )(j-1) = k }
    if (        j<59 && floor(i  )(j+1) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i  )(j+1) = k }
    if (i<59         && floor(i+1)(j  ) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i+1)(j  ) = k }
    if (i<59 && j<59 && floor(i+1)(j+1) != -1 && floor(i)(j) != k ) { println(s"i: $i, j: $j"); floor(i+1)(j+1) = k }
  }
  for (i <- 0 to 59; j <- 0 to 59) {
    print(s"${floor(i)(j)%4.0d} ")
    if (j == 59) println("")
  }
  val cnt: Int = (for ( i <- 0 to 59; j <- 0 to 59 ) yield if (floor(i)(j) >= 0) { 1 } else { 0 }) sum
  val _ = println(cnt)
}

