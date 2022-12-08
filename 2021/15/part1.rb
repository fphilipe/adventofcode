require 'set'

lines = ARGF.readlines.map(&:chomp)
size = lines.length
risks = lines.join.chars.map(&:to_i)

unvisited = (0...risks.length).to_set
dists = Array.new(risks.length, Float::INFINITY)
dists[0] = 0

puts 1.step.reduce([unvisited, dists]) { |(unvisited, dists), _|
  i = unvisited.min_by { dists[_1] }
  unvisited.delete(i)

  neighbors = []
  neighbors << i + size if i + size < risks.length
  neighbors << i.succ if i.succ % size > 0
  neighbors.each do |j|
    dists[j] = [dists[j], dists[i] + risks[j]].min
  end

  break dists.last if unvisited.empty?

  [unvisited, dists]
}
