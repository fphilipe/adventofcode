String.class_exec { def small? = downcase == self }

graph = ARGF.readlines
  .map { _1.chomp.split('-') }
  .map { [_1, _1.reverse] }
  .flatten(1)
  .group_by(&:first)
  .transform_values { _1.map(&:last) }

def find(node, graph, path=[])
  return if node == "start" && !path.empty?
  return if node.small? && path.include?(node) && path.filter(&:small?).tally.any? { _2 > 1 }

  path += [node]
  if node == "end"
    return path.join(",")
  end

  graph[node]
    .flat_map { |node| find(node, graph, path) }
    .compact
end

puts find("start", graph).length
