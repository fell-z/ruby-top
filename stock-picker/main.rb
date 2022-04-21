def stock_picker(prices)
  valid_pairs = find_valid_pairs(find_highests(prices), find_lowests(prices))

  profit = 0
  valid_pairs.reduce([]) do |best_pair, pair|
    if (pair[1] - pair[0]) > profit
      profit = pair[1] - pair[0]
      best_pair = [prices.index(pair[0]), prices.index(pair[1])]
    end
    best_pair
  end
end

def find_valid_pairs(highest_pairs, lowest_pairs)
  highest_pairs.reduce([]) do |valid_pair, highest|
    lowest_pairs.each do |lowest|
      next unless lowest[:index] < highest[:index]

      valid_pair.push [lowest[:value], highest[:value]]
    end
    valid_pair
  end
end

def find_highests(arr)
  total_of_values = (arr.length / 2).floor
  highest_values = arr.max(total_of_values)

  Array.new(total_of_values) { |index| { value: highest_values[index], index: arr.index(highest_values[index]) } }
end

def find_lowests(arr)
  total_of_values = (arr.length / 2).floor
  lowest_values = arr.min(total_of_values)

  Array.new(total_of_values) { |index| { value: lowest_values[index], index: arr.index(lowest_values[index]) } }
end
