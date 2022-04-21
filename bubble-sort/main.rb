def bubble_sort(array)
  swaps = 1
  while swaps != 0
    swaps = 0
    array.each_with_index do |element, index|
      actual_index = array.index element
      next_element = array[index + 1]
      next if next_element.nil?

      if element > next_element
        array[index + 1] = element
        array[actual_index] = next_element
        swaps += 1
      end
    end
  end
  array
end
