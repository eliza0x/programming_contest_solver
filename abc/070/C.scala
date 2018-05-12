object Main {
  def main(args: Array[String]) {
    val scan = new java.util.Scanner(System.in)
    val n  = scan.next.toInt
    val ts = (1 to n).toList.map(_ => BigInt(scan.next))
    println(ts.reduceLeft((a,b) => lcm(a,b)))
  }

  def gcd(a: BigInt, b: BigInt): BigInt = if (b == 0) a else gcd(b, a % b)
  def lcm(a: BigInt, b: BigInt): BigInt = a * b / gcd(a, b)
}
