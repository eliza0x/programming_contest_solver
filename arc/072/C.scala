object Main extends App {
  val scan = new java.util.Scanner(System.in)
  val n  = scan.next().toInt
  val ns = (1 to n).map(_ => scan.next().toInt)

  var even_sum = 0L
  var even_cnt = 0L
  for (i <- 0 until n) {
    even_sum += ns(i)
    if (i%2 == 0) {
      if (even_sum == 0) {
        even_sum += 1L
        even_cnt += 1L
      } else if (even_sum < 0L) {
        even_cnt += (1L-even_sum)
        even_sum = 1L
      }
    } else {
      if (even_sum == 0L) {
        even_sum -= 1L
        even_cnt += 1L
      } else if (even_sum > 0L) {
        even_cnt += (1L+even_sum)
        even_sum = -1L
      }
    }
  }

  var odd_sum = 0L
  var odd_cnt = 0L
  for (i <- 0 until n) {
    odd_sum += ns(i)
    if (i%2 != 0) {
      if (odd_sum == 0L) {
        odd_sum += 1L
        odd_cnt += 1L
      } else if (odd_sum < 0) {
        odd_cnt += (1L-odd_sum)
        odd_sum = 1L
      }
    } else {
      if (odd_sum == 0L) {
        odd_sum -= 1L
        odd_cnt += 1L
      } else if (odd_sum > 0) {
        odd_cnt += (1L+odd_sum)
        odd_sum = -1L
      }
    }
  }
  println(math.min(odd_cnt, even_cnt))
}
