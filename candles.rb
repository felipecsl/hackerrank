#!/bin/ruby
# https://www.hackerrank.com/challenges/birthday-cake-candles
n = gets.strip.to_i
candles = gets.strip.split(' ').map(&:to_i)
max = 0
total = 0
candles.each do |c|
  if c > max
    total = 1
    max = c
  elsif c == max
    total += 1
  end
end

puts total
