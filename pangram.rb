#!/bin/ruby
# https://www.hackerrank.com/challenges/pangrams?h_r=next-challenge&h_v=zen
ALPHABET = %w(a b c d e f g h i j k l m n o p q r s t u v x y w z)

def check_phrase(phrase, alphabet)
  return true if alphabet.empty?
  return false if alphabet.size > phrase.size
  return check_phrase(phrase[1..-1], alphabet.reject { |i| i.upcase == phrase[0].upcase })
end

if check_phrase(gets.strip, ALPHABET)
  puts "pangram"
else
  puts "not pangram"
end
