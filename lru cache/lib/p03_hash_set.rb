require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 7)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count == num_buckets
    unless self[key].include?(key)
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_bucket_size = @count * 2
    new_store = Array.new(new_bucket_size) {Array.new}
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el.hash % new_bucket_size] << el
      end
    end
    @store = new_store
  end
end
