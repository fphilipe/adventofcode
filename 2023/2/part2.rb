puts ARGF.readlines.sum { |line|
  %w[red green blue]
    .map { line.scan(/(\d+) #{_1}/).flatten.map(&:to_i).max }
    .inject(:*)
}
