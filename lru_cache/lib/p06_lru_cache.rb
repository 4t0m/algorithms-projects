require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count, :max

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      link.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: #{@map} \nStore: #{@store}"
  end

  private

  def calc!(key)
    val = @prc.call(key)
    link = @store.append(key, val)
    @map.set(key, link)

    eject! if count > max
    val
  end

  def update_link!(link)
    link.remove
    @store.append(link.key, link.val)
  end

  def eject!
    lru_key = @store.first.key
    @store.remove(lru_key)
    @map.delete(lru_key)

    nil
  end
end
