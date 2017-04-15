class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity, nil)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @count
    @store[i]
  end

  def []=(i, val)
    until capacity > i
      resize!
    end

    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    each { |el| return true if el == val }
    false
  end

  def push(val)
    resize! if @count >= capacity
    self[count] = val
    @count += 1
  end

  def unshift(val)
    new_capacity = capacity
    if @count == capacity
      new_capacity *= 2
    end

    new_store = StaticArray.new(new_capacity)
    new_store[0] = val

    (0...@count).each do |i|
      new_store[i + 1] = @store[i]
    end

    @count += 1
    @store = new_store
  end

  def pop
    return nil if @count == 0
    @count -= 1
    self[@count]
  end

  def shift
    @count -= 1
  end

  def first
    self[0]
  end

  def last
    self[@count]
  end

  def each
    (0...@count).each do |index|
      yield self[index]
    end

    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @count == other.count

    (0...@count).each do |index|
      return false unless self[index] == other[index]
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_capacity = capacity * 2
    new_store = StaticArray.new(new_capacity)
    (0...@count).each do |i|
      new_store[i] = @store[i]
    end

    @store = new_store
  end
end
