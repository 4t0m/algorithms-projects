class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).
	# TODO use random index for pivot instead of first

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left, right = array.drop(1).partition { |el| el <= pivot }
    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    prc ||= proc { |el1, el2| el1 <=> el2 }

    pivot_idx = self.partition(array, start, length, &prc)
    left_length = pivot_idx - start
    right_length = length - left_length - 1
    self.sort2!(array, start, left_length, &prc)
    self.sort2!(array, pivot_idx + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= proc { |el1, el2| el1 <=> el2 }
    partition_idx = start
    ((start + 1)...(start + length)).each do |index|
      next if prc.call(array[start], array[index]) == -1
			partition_idx += 1
			array[partition_idx], array[index] = array[index], array[partition_idx]
    end

    array[start], array[partition_idx] = array[partition_idx], array[start]
    partition_idx
  end
end
