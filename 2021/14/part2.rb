top, bottom = ARGF.read.split("\n\n")
polymer = top.chars
rules = bottom
  .split("\n")
  .map { |line|
    left, c = line.split(" -> ")
    a, b = left.chars
    [[a, b], [[a, c], [c, b]]]
  }
  .to_h

pair_tally = 40.times.reduce(polymer.each_cons(2).tally) do |tally, _|
  {}.tap do |next_tally|
    next_tally.default = 0
    tally.each { |pair, count|
      rules[pair].each { next_tally[_1] += count }
    }
  end
end

char_tally = { polymer.last => 1 }
char_tally.default = 0
pair_tally.each { |(a, _), count| char_tally[a] += count }

min, max = char_tally.values.minmax
puts max - min
