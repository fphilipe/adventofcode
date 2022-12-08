require 'set'

Coord = Struct.new(:x, :y) do
  def adjacent
    [-1, 0, 1]
      .product([-1, 0, 1])
      .filter { !_1.all?(&:zero?) }
      .map do |(dx, dy)|
        Coord.new(x + dx, y + dy)
      end
  end
end

Cell = Struct.new(:value, :coord)

class Field
  include Enumerable

  def initialize(values)
    @values = values
    @width = values.first.length
    @height = values.length
    @flash_count = 0
  end

  def [](coord) = @values[coord.y][coord.x]

  def []=(coord, value)
    @values[coord.y][coord.x] = value
  end

  def adjacent_coords(coord)
    coord.adjacent.filter do |coord|
      coord.x >= 0 && coord.x < @width &&
      coord.y >= 0 && coord.y < @height
    end
  end

  def each(&block)
    @values.each.with_index do |row, y|
      row.each.with_index do |value, x|
        yield Cell.new(value, Coord.new(x, y))
      end
    end
  end

  def step
    each { increment(_1.coord) }
    each { self[_1.coord] = 0 if self[_1.coord] > 9 }
  end

  def increment(coord)
    self[coord] += 1
    if self[coord] == 10
      @flash_count += 1
      adjacent_coords(coord).each { increment(_1) }
    end
  end

  def part1
    100.times { step }
    @flash_count
  end

  def part2
    1.step do |count|
      step
      break count if map(&:value).uniq.one?
    end
  end
end

part = ARGV.shift.to_i

field = Field.new(
  ARGF.readlines.map { _1.chomp.split("").map(&:to_i) }
)

puts field.send("part#{part}")
