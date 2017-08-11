def first_anagram?(str1, str2)
  anagrams = []
  str1.length.times do |i|
    char = str1.chars[i]
    substring = str1[0...i] + str1[i + 1..-1]
    perms = substring.chars.permutation.to_a
    perms.each { |perm| anagrams << char + perm.join }
  end
  anagrams.include?(str2)
end

# == > n!

def second_anagram?(str1, str2)
  str1_copy = str1.split('')
  str2_copy = str2.split('')
  str1.chars.each.with_index do |ch1, i1|
    str2.chars.each.with_index do |ch2, i2|
      if ch1 == ch2
        str1_copy[i1] = ''
        str2_copy[i2] = ''
      end
    end
  end
  str1_copy.join == str2_copy.join
end

# == > n ^ 2

def third_anagram?(str1, str2)
  str1.chars.sort == str2.chars.sort
end

# == > log(n)

def fourth_anagram(str1, str2)
  str1_hash = Hash.new(0)
  str2_hash = Hash.new(0)
  str1.each_char { |char| str1_hash[char] += 1 }
  str2.each_char { |char| str2_hash[char] += 1 }
  str1_hash == str2_hash
end

# == > n

# def fifth_anagram?(str1, str2)
#   return false unless str1.length == str2.length
#   total_string = str1 + str2
#   middle = total_string.length / 2
#   hash = Hash.new(0)
#
#   total_string.chars.each_with_index do |char, i|
#     if i <= middle
#       hash[char] += 1 unless hash.key?(char)
#     end
#   end
#
#   !hash.values.any? {|value| value.odd?}
# end
