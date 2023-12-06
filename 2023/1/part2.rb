@digits = %w[zero one two three four five six seven eight nine]
@regex = /(?=(#{@digits.join("|")}|\d))/

puts ARGF.readlines.sum { |line|
  line
    .scan(@regex)
    .flatten
    .values_at(0, -1)
    .map { @digits.index(_1) || _1 }
    .join
    .to_i
}
