class BinaryMinHeap
  def initialize(&prc)
		@store = []
  end

  def count
		@store.length
  end

  def extract
    min = @store[0]
    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0)
    min
  end

  def peek
		@store.first
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
		index_1, index_2 = (parent_index == 0 ? [1, 2] : [parent_index * 2 + 1, parent_index * 2 + 2])
		[index_1, index_2].reject { |i| i >= len }
  end

  def self.parent_index(child_index)
		raise "root has no parent" if child_index == 0
		(child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= proc { |el1, el2| el1 <=> el2 }
		child_indices = self.child_indices(len, parent_idx)
		children = child_indices.map { |i| array[i] }
	  sorted = children.sort(&prc)

    return array if sorted.empty?

    case prc.call(sorted[0], array[parent_idx])
    when -1
      child_idx = array.index(sorted[0])
      array[child_idx] = array[parent_idx]
  		array[parent_idx] = sorted[0]
    else
      return array
    end

		self.heapify_down(array, child_idx, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= proc { |el1, el2| el1 <=> el2 }
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    case prc.call(array[parent_idx], array[child_idx])
    when 1
      array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    else
      return array
    end

    self.heapify_up(array, parent_idx, &prc)
  end
end
