require_relative "heap"

class Array
  def heap_sort!
    (1...self.length).each do |i|
      BinaryMinHeap.heapify_up(self, i) { |el1, el2| el2 <=> el1 }
    end

    heap_end_index = self.length - 1
    until heap_end_index == 0
      self[0], self[heap_end_index] = self[heap_end_index], self[0]
      BinaryMinHeap.heapify_down(self, 0, heap_end_index) { |el1, el2| el2 <=> el1 }
      heap_end_index -= 1
    end

    self
  end
end
