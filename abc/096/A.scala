object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val a = scan.next().toInt
  val b = scan.next().toInt
  val n = if (b >= a) { a } else { a-1 } 
  println(n)
}
