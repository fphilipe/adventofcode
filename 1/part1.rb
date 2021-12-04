puts ARGF.readlines
  .map(&:to_i)
  .slice_when(&:<)
  .count
  .pred
