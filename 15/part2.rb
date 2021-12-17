require 'set'
require 'algorithms'

grid_template = ARGF.readlines.map { _1.chomp.chars.map(&:to_i) }
size = grid_template.length

grid = Array.new(5 * size) { Array.new(5 * size) }

size.times do |x|
  size.times do |y|
    5.times do |dx|
      5.times do |dy|
        grid[y + dy * size][x + dx * size] = ((grid_template[y][x] + dx + dy) - 1) % 9 + 1
      end
    end
  end
end

risks = grid.flatten
size *= 5

unvisited = (0...risks.length).to_set
dists = Array.new(risks.length, Float::INFINITY)
dists[0] = 0
candidates = Containers::PriorityQueue.new
candidates.push(0, 0)

puts 1.step.reduce([unvisited, dists]) { |(unvisited, dists), n|
  i = candidates.pop

  if unvisited.include?(i)
    unvisited.delete(i)

    neighbors = []
    neighbors << i.succ if i.succ % size > 0
    neighbors << i.pred if i % size > 0
    neighbors << i + size if i + size < risks.length
    neighbors << i - size if i > size

    neighbors.each do |j|
      dists[j] = [dists[j], dists[i] + risks[j]].min
      candidates.push(j, -dists[j])
    end

    break dists.last if unvisited.empty?
  end

  [unvisited, dists]
}
