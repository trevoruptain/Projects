class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    @prev.next = @next
    @next.prev = @prev
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
    @head.val.nil?
  end

  def get(key)
    each do |node|
      return node.val if node.key == key
    end
  end

  def get_node(key)
    each do |node|
      return node if node.key == key
    end
  end

  def include?(key)
    get(key) ? true : false
  end

  def append(key, val)
    if empty?
      @head = Node.new(key, val)
      @tail = @head
    else
      new_node = Node.new(key, val)
      @tail.next = new_node
      new_node.prev = @tail
      @tail = new_node
    end
  end

  def update(key, val)
    each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    each do |node|
      next if node.key != key

      if @head == @tail
        @head = Node.new
        @tail = @head
      else
        node.prev.next = node.next unless node.prev.nil?
        node.next.prev = node.prev unless node.next.nil?
        if node == @head
          @head = node.next
        elsif node == @tail
          @tail = node.prev
        end
      end
    end
  end


  def each(&prc)
    unless empty?
      current_node = @head
      until current_node.nil?
        prc.call(current_node)
        current_node = current_node.next
      end
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
