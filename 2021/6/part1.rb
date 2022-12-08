def step(state)
  state.flat_map { |n| n.zero? ? [6, 8] : n - 1 }
end

days = ARGV.shift.to_i
initial_state = ARGF.read.split(",").map(&:to_i)

puts days.times.reduce(initial_state) { step(_1) }.count
