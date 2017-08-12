require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'
class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 7)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    bucket = bucket(key)
    if bucket.include?(key)
      bucket.update(key, val)
    else
      bucket.append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[bucket_index(key)].get(key)
  end

  def delete(key)
    if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
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
    new_store = Array.new(@count * 2) {LinkedList.new}
    self.each do |k, v|
      new_store[k.hash % (@count * 2)].append(k, v)
    end
    @store = new_store
  end

  def bucket_index(key)
    key.hash % num_buckets
  end

  def bucket(key)
    @store[bucket_index(key)]
  end
end
