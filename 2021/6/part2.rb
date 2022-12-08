@memo = {}

def fish(state, days_remaining)
  @memo[[state, days_remaining]] ||=
    1 + (days_remaining - state).step(0, -7).sum do |days_remaining|
      fish(9, days_remaining)
    end
end

days = ARGV.shift.to_i
initial_state = ARGF.read.split(",").map(&:to_i)

puts initial_state.sum { fish(_1, days.pred) }
