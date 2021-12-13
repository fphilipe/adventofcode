@opening = "([{<".chars
@closing = ")]}>".chars
@points = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4,
}

def score(line)
  remaining_stack = line.chomp.chars.each_with_object([]) do |char, stack|
    if @opening.include?(char)
      stack.push(char)
    else
      expected = @closing[@opening.index(stack.pop)]
      return nil if char != expected
    end
  end

  remaining_stack.reverse.reduce(0) do |score, char|
    score * 5 + @points[@closing[@opening.index(char)]]
  end
end

scores = ARGF.readlines.map { score(_1) }.compact.sort
puts scores[scores.length / 2]
