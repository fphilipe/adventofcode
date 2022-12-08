def median(values)
  center = values.length.pred / 2.0
  elements = values[center.floor..center.ceil]
  elements.sum / elements.length
end

positions = ARGF.read.split(",").map(&:to_i).sort
ideal_position = median(positions)

puts positions.sum { (_1 - ideal_position).abs }
