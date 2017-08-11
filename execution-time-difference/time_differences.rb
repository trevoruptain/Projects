def shitty_my_min(array)
  min = array[0]
  array.each do |el1|
    array.each do |el2|
      if el2 < el1
        min = el2 if el2 < min
      end
    end
  end
  min
end

# ==> n ^ 2

def better_my_min(array)
  min = array[0]
  array.each do |el|
    min = el if el < min
  end
  min
end

# ==> n

def shitty_subsum(array)
  subsets = []

  for i in 0..array.length-1
    for j in i..array.length-1
      subsets << array[i..j]
    end
  end
  totals = subsets.map do |subset|
    subset.inject(:+)
  end
  totals.max
end

def better_subsum(array)
  largest_sum = array[0]
  current_sum = 0
  array.each do |el|
    current_sum += el
    largest_sum = current_sum if current_sum > largest_sum
    current_sum = 0 if current_sum < 0
  end
  largest_sum
end

# ____
# total_sum = array.first
# answer = 0
# array.each do |el|
#   total_sum += el
#   if total_sum < total_sum
#     answer = 0
#     total_sum = 0
#   else
#     answer = total_sum
#   end
# end
