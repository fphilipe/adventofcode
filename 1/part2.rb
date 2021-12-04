puts ARGF.readlines
  .map(&:to_i)
  .each_cons(3)
  .map(&:sum)
  .slice_when(&:<)
  .count
  .pred
