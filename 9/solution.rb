require 'set'

Coord = Struct.new(:x, :y) do
  def adjacent
    [[0, 1], [1, 0], [0, -1], [-1, 0]].map do |(dx, dy)|
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
  end

  def [](coord) = @values[coord.y][coord.x]

  def adjacent_coords(coord)
    coord.adjacent.filter do |coord|
      coord.x >= 0 && coord.x < @width &&
      coord.y >= 0 && coord.y < @height
    end
  end

  def adjacent_cells(coord)
    adjacent_coords(coord)
      .map { |coord| Cell.new(self[coord], coord) }
      .to_set
  end

  def each(&block)
    @values.each.with_index do |row, y|
      row.each.with_index do |value, x|
        yield Cell.new(value, Coord.new(x, y))
      end
    end
  end

  def low_points
    filter do |cell|
      adjacent_cells(cell.coord).all? do |adjacent_cell|
        adjacent_cell.value > cell.value
      end
    end
  end

  def part1
    low_points.sum { _1.value.succ }
  end

  def basins
    low_points.map { grow_basin(_1) }
  end

  def grow_basin(cell, basin = Set.new)
    return basin if cell.value == 9 || basin.include?(cell)
    basin << cell
    adjacent_cells(cell.coord).subtract(basin).reduce(basin) do |basin, cell|
      grow_basin(cell, basin)
    end
  end

  def part2
    basins.map(&:length).sort.last(3).reduce(:*)
  end
end

part = ARGV.shift.to_i

field = Field.new(
  ARGF.readlines.map { _1.chomp.split("").map(&:to_i) }
)

puts field.send("part#{part}")
