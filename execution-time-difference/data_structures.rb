class MyQueue
  def initialize
    @store = []
  end

  def enqueue(ele)
    @store << ele
  end

  def dequeue
    @store.shift
  end

  def peek
    @store.first
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop!
  end

  def push(ele)
    @store.push(ele)
  end

  def peek
    @store.last
  end

  def size
    @store.length
  end

  def empty?
    @store.empty?
  end
end

class StackQueue < MyStack
  def initialize
    super
  end

  def enqueue(ele)
  end

  def dequeue
  end

  def size
  end

  def empty?
  end
end
