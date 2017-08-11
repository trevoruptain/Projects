def bad_two_sum?(array, target)
  for i in 0...array.length - 1
    for j in i + 1...array.length
      return true if array[i] + array[j] == target
    end
  end
  false
end

def okay_two_sum?(array, target)
  array.sort!
  left_i = 0
  right_i = array.length - 1

  until left_i == right_i
    sum = array[left_i] + array[right_i]
    return true if sum == target
    if sum > 10
      right_i -= 1
    else
      left_i += 1
    end
  end
  false
end

def two_sum?(array, target)
  hash = Hash.new(0)
  array.each { |num| hash[num] += 1 }
  array.each do |num|
    unless num == target - num && hash[num] == 1
      return true if hash.key?(target - num)
    end
  end
  false
end
