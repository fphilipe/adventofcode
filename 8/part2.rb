require 'set'

class Array
  def delete_matching(&block) = delete_at(index(&block))
end

def resolve(patterns)
  Array.new(10).tap do |sol|
    sol[1] = patterns.delete_matching { _1.length == 2 }
    sol[4] = patterns.delete_matching { _1.length == 4 }
    sol[7] = patterns.delete_matching { _1.length == 3 }
    sol[8] = patterns.delete_matching { _1.length == 7 }

    sol[6] = patterns.delete_matching { _1.superset?(sol[8] - sol[1]) }
    sol[9] = patterns.delete_matching { _1.length == 6 && _1.superset?(sol[4]) }
    sol[0] = patterns.delete_matching { _1.length == 6 }
    sol[5] = patterns.delete_matching { _1.subset?(sol[6]) }
    sol[3] = patterns.delete_matching { _1.subset?(sol[9]) }
    sol[2] = patterns.first
  end
end

puts ARGF.readlines
  .map { |line|
    patterns, output = line.chomp.split(" | ").map { |parts|
      parts.split(" ").map { _1.chars.to_set }
    }
    solution = resolve(patterns)
    output.map { solution.index(_1) }.join.to_i
  }
  .sum
