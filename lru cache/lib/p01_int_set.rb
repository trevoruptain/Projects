require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise_error unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise_error unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise_error unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num <= @max
  end

  def validate!(num)
  end

  def raise_error
    raise ArgumentError.new "Out of bounds"
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket_index = num % num_buckets
    @store[bucket_index]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets

    unless include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    @store[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(count * 2) { Array.new }

    @store.each do |bucket_container|
      bucket_container.each do |num|
        new_mod_value = num % (count * 2)
        new_store[new_mod_value] << num
      end
    end
    @store = new_store
  end
end
