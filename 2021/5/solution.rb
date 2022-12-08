Point = Struct.new(:x, :y)

Line = Struct.new(:a, :b) do
  def points
    xs = range(a.x, b.x)
    ys = range(a.y, b.y)

    if xs.count >= ys.count
      xs.zip(ys.cycle)
    else
      ys.zip(xs.cycle).map(&:reverse)
    end
      .map { Point.new(*_1) }
  end

  def range(from, to) = from <= to ? from.upto(to) : from.downto(to)

  def non_diagonal? = a.x == b.x || a.y == b.y
end

Field = Struct.new(:lines) do
  def self.parse(input)
    self.new(
      input.lines.map { |line|
        Line.new(
          *line.split(" -> ").map {
            Point.new(*_1.split(",").map(&:to_i))
          }
        )
      }
    )
  end

  def count_overlapping
    lines
      .flat_map(&:points)
      .tally
      .count { _2 > 1 }
  end

  def count_overlapping_non_diagonal
    self.class.new(lines.filter(&:non_diagonal?)).count_overlapping
  end
end

if ARGV.shift == "1"
  puts Field.parse(ARGF.read).count_overlapping_non_diagonal
else
  puts Field.parse(ARGF.read).count_overlapping
end
