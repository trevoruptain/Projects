require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
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
      update_node(@map[key])
      return @store.last.value
    else
      value = @prc.call(key)
      @store.append(key, value)
      @map.set(key, @map[key])
    end

    if @map.count > @max
      eject!
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)

  end

  def update_node!(node)
    key, value = node.key, node.value
    @store.remove(key)
    @store.append(key, value)
  end

  def eject!
    rem_key = @store.first.key
    @store.remove(rem_key)
    @map.delete(rem_key)
  end
end
