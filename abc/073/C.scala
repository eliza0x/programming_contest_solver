object Main extends App {
  val s = new java.util.Scanner(System.in)
  val n = s.next().toInt
  val ns = (1 to n).map(_ => s.next().toLong).sorted.toList
  println(group(ns).filter(_._2%2 == 1).length)

  
  def group(l: List[Long]): List[(Long, Long)] = {
    def g(l: List[(Long, Long)]): List[(Long, Long)] = l match {
      case x::y::ll => if (x==y) {g((x._1, x._2+y._2)::ll)} else {x::g(y::l)} 
      case List(x)  => List(x)
      case List()   => List()
    }
    g(l.map((_, 1L)))
  }
}

