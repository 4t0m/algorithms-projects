require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    relevant_list = bucket(key)
    if relevant_list.include?(key)
      relevant_list.update(key, val)
    else
      @count += 1
      resize! if @count > num_buckets
      relevant_list.append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if include?(key)
      @count -= 1
      bucket(key).remove(key)
    end
  end

  def each(&prc)
    @store.each do |list|
      list.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k} => #{v}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }

    @store.each do |list|
      list.each do |link|
        new_bucket = new_store[link.key.hash % new_num_buckets]
        new_bucket.append(link.key, link.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
