def merge_sort(array)
  return array if array.length == 1

  left_half = merge_sort(array[0..(array.length / 2 - 1)])
  right_half = merge_sort(array[(array.length / 2)..])

  sorted_array = []
  loop do
    break if left_half.empty? && right_half.empty?

    if left_half.empty?
      sorted_array << right_half.delete_at(0)
      next
    elsif right_half.empty?
      sorted_array << left_half.delete_at(0)
      next
    end

    sorted_array <<
      if left_half[0] > right_half[0]
        right_half.delete_at(0)
      else
        left_half.delete_at(0)
      end
  end
  sorted_array
end
