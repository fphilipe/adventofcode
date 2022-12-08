segment_counts = [
  2, # 1
  4, # 4
  3, # 7
  7, # 8
]

puts ARGF.readlines
  .flat_map { _1.split(" | ").last.split(" ").map(&:length) }
  .filter { segment_counts.include?(_1) }
  .count
