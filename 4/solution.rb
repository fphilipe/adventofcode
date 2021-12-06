class Game
  def initialize(input)
    drawn_numbers, *boards = input.split("\n\n")
    @drawn_numbers = drawn_numbers.split(",").map(&:to_i)
    @boards = boards.map do |board|
      numbers = board.split("\n").map { _1.strip.split(/\s+/).map(&:to_i) }
      Board.new(numbers)
    end
  end

  def play_part1
    @drawn_numbers.each do |number|
      @boards.each do |board|
        if result = board.mark(number)
          return result
        end
      end
    end
  end

  def play_part2
    @drawn_numbers.each do |number|
      if @boards.one? && result = @boards.first.mark(number)
        return result
      else
        @boards.filter! do |board|
          board.mark(number).nil?
        end
      end
    end
  end
end

class Board
  def initialize(numbers)
    @numbers = numbers
    @marked = numbers.map { _1.map { false } }
  end

  def mark(number)
    i, j = index(number)
    return unless i && j
    @marked[i][j] = true
    unmarked_sum * number if completed?
  end

  def index(number)
    @numbers.each.with_index do |row, i|
      if j = row.index(number)
        return [i, j]
      end
    end
    nil
  end

  def completed?
    @marked.any?(&:all?) || @marked.transpose.any?(&:all?)
  end

  def unmarked_sum
    @marked.flat_map.with_index do |row, i|
      row.map.with_index do |is_marked, j|
        is_marked ? 0 : @numbers[i][j]
      end
    end.sum
  end
end

part = ARGV.shift
puts Game.new(ARGF.read).send("play_part#{part}")
