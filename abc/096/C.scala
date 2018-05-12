object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val h, w = scan.next().toInt
  val map: Array[String] = for (_ <- (1 to h).toArray) 
                           yield scan.next()
  var flag = true
  for (y <- 0 until h) {
    for (x <- 0 until w) {
      if (map(y)(x) == '#') {
        if      (y-1 >= 0 && map(y-1)(x) == '#') {}
        else if (y+1 <  h && map(y+1)(x) == '#') {}
        else if (x-1 >= 0 && map(y)(x-1) == '#') {}
        else if (x+1 <  w && map(y)(x+1) == '#') {}
        else { flag = false }
      }
    }
  }
  println(if (flag) {"Yes"} else {"No"} )
}
