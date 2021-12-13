@opening = "([{<".chars
@closing = ")]}>".chars
@points = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137,
}

def score(line)
  line.chomp.chars.each_with_object([]) do |char, stack|
    if @opening.include?(char)
      stack.push(char)
    else
      expected = @closing[@opening.index(stack.pop)]
      return @points[char] if char != expected
    end
  end

  0
end

puts ARGF.readlines.sum { score(_1) }
