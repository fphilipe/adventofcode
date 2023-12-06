@cubes = { "red" => 12, "green" => 13, "blue" => 14 }

def possible?(game)
  @cubes.all? do |color, count|
    game.scan(/(\d+) #{color}/).flatten.map(&:to_i).max <= count
  end
end

puts ARGF.readlines
  .sum {
    if possible? _1
      _1.scan(/Game (\d+)/).first.first.to_i
    else
      0
    end
  }
