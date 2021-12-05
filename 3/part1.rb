data = ARGF.readlines
  .map(&:chomp)
  .map(&:chars)
  .map { _1.map(&:to_i) }

line_count = data.count
max = (1 << data.first.count) - 1

gamma = data.transpose
  .map(&:sum)
  .map { _1 > line_count / 2.0 ? 1 : 0 }
  .join
  .to_i(2)

epsilon = max - gamma

puts gamma * epsilon
