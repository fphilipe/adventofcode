puts ARGF.readlines.sum { _1.scan(/\d/).values_at(0, -1).join.to_i }
