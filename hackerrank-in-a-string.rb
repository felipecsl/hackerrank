#!/bin/ruby
# https://www.hackerrank.com/challenges/hackerrank-in-a-string
q = gets.strip.to_i
lookup = "hackerrank"

def check_word(word, suffix)
  return true if suffix.empty?
  return false if word.empty?
  if word[0] == suffix[0]
    return check_word(word[1..-1], suffix[1..-1])
  else
    return check_word(word[1..-1], suffix)
  end
end

for a0 in (0..q - 1)
  if check_word(gets.strip, lookup)
    puts "YES"
  else
    puts "NO"
  end
end
