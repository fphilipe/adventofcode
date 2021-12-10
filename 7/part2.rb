positions = ARGF.read.split(",").map(&:to_i)

def cost(from, to)
  delta = (from - to).abs
  delta * delta.succ / 2
end

puts Range.new(*positions.minmax).map { |candidate|
  positions.sum { cost(_1, candidate) }
}.min
