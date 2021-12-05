def significant_bit(data, operation, index)
  data.sum { _1[index] }.send(operation, data.count / 2.0) ? 1 : 0
end

def filter(data, index, operation)
  bit = significant_bit(data, operation, index)
  data.filter { _1[index] == bit }
end

def run(data, operation)
  bit_count = data.first.count
  bit_count.times.reduce(data) { |data, index|
    filtered = filter(data, index, operation)
    return filtered.first.join.to_i(2) if filtered.one?
    filtered
  }
end

def oxygen_generator_rating(data) = run(data, :<)
def co2_scrubber_rating(data)     = run(data, :>=)

data = ARGF.readlines
  .map(&:chomp)
  .map(&:chars)
  .map { _1.map(&:to_i) }

puts oxygen_generator_rating(data) * co2_scrubber_rating(data)
