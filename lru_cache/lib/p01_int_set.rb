class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[bucket(num)] << num
  end

  def remove(num)
    @store[bucket(num)].delete(num)
  end

  def include?(num)
    @store[bucket(num)].include?(num)
  end

  private

  def bucket(num)
    num % @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == count
    @store[bucket(num)] << num
    @count += 1
  end

  def remove(num)
    @count -= 1
    @store[bucket(num)].delete(num)
  end

  def include?(num)
    @store[bucket(num)].include?(num)
  end


  private

  def num_buckets
    @store.length
  end

  def bucket(num)
    num % num_buckets
  end

  def resize!
    old_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |num| insert(num) }
  end
end
