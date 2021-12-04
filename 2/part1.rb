Position = Struct.new(:horizontal, :depth) do
  def forward(count) self.horizontal += count end
  def down(count)    self.depth      += count end
  def up(count)      self.depth      -= count end

  def multiply; horizontal * depth end
end

puts ARGF.readlines
  .each_with_object(Position.new(0, 0)) { |step, pos|
    cmd, count = step.split(" ")
    pos.send(cmd, count.to_i)
  }
  .multiply
