top, bottom = ARGF.read.split("\n\n")
polymer = top.chars
@rules = bottom
  .split("\n")
  .map { |line| line.split(" -> ") }
  .to_h
  .transform_keys(&:chars)

def step(polymer)
  [polymer.first] + polymer.each_cons(2).flat_map { [@rules[_1], _1.last] }
end

min, max = 10.times.reduce(polymer) { step(_1) }.tally.values.sort.minmax
puts max - min
