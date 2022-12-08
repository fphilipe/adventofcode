part = ARGV.shift
top, bottom = ARGF.read.split("\n\n")

dots = top.lines.map { _1.split(",").map(&:to_i) }
@fold_instructions = bottom.lines.map { |line| line.scan(/(?<=x=)(\d+)|(?<=y=)(\d+)/).flatten.map { _1&.to_i } }

width, height = dots.transpose.map(&:max).map(&:succ)
width += 1 if width.even?
height += 1 if height.even?

@paper = Array.new(height) { Array.new(width, false) }
dots.each { |(x, y)| @paper[y][x] = true }

def fold_y(paper, y)
  paper[...y]
    .zip(paper[y.succ..].reverse)
    .map { |rows|
      rows.inject(&:zip).map { |cells| cells.inject(&:|) }
    }
end

def fold(paper, instruction)
  case instruction
  in [x, nil] then fold_y(paper.transpose, x).transpose
  in [nil, y] then fold_y(paper, y)
  end
end

def part1
  puts fold(@paper, @fold_instructions.first).flatten.count(&:itself)
end

def part2
  puts @fold_instructions
    .reduce(@paper) { fold(_1, _2) }
    .map { |row| row.map { _1 ? "█" : " " }.join }
    .join("\n")
end

send("part#{part}")
