require_relative './data_structures'

def windowed_max_range(array, w)
  current_max_range = nil

  array.each_cons(w) do |window|
    min = window[0]
    max = window[0]

    window.each do |num|
      min = num if num < min
      max = num if num > max
    end

    range = max - min
    current_max_range = range if current_max_range.nil?
    current_max_range = range if range > current_max_range
  end

  current_max_range
end

# == > n ^ 2
