object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n, p = scan.next().toInt
  val ns = for (_<-(1 to n).toArray) 
    yield (scan.next().toInt, scan.next().toInt, scan.next().toInt)

}
