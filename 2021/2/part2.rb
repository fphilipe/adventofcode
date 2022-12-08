Position = Struct.new(:aim, :horizontal, :depth) do
  def down(count) = self.aim += count
  def up(count)   = self.aim -= count

  def forward(count)
    self.horizontal += count
    self.depth += aim * count
  end

  def multiply = horizontal * depth
end

puts ARGF.readlines
  .each_with_object(Position.new(0, 0, 0)) { |step, pos|
    cmd, count = step.split(" ")
    pos.send(cmd, count.to_i)
  }
  .multiply
