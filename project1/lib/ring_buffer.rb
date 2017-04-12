require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @start_idx = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    true_index = (@start_idx + index) % @capacity
    @store[true_index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    true_index = (@start_idx + index) % @capacity
    @store[true_index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[(@start_idx + @length) % @capacity]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[(@start_idx + @length) % @capacity] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted_el = @store[@start_idx]
    @start_idx = (@start_idx == @capacity ? 0 : @start_idx + 1)
    @length -= 1
    shifted_el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx == 0 ? @capacity - 1 : @start_idx - 1)
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index > @length - 1
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (@start_idx...(@start_idx + @length)).each do |i|
      true_index = i % (@capacity / 2)
      new_store[i] = @store[true_index]
    end

    @store = new_store
  end
end
