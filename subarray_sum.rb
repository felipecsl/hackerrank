# Given a target sum, populate all subsets, whose sum is equal to the target sum,
# from an int array.
#
# For example:
#
# Target sum is 15.
#
# An int array is { 1, 3, 4, 5, 6, 15 }.
#
# Then all satisfied subsets whose sum is 15 are as follows:
#
# 15 = 1+3+5+6
# 15 = 4+5+6
# 15 = 15
def solve(arr, curr_subset, target)
  return if arr.empty?
  curr = arr[0]
  if curr == target
    p(curr_subset + [curr])
  else
    1.upto(arr.size - 1).each do |i|
      if target - curr > 0
        solve(arr.drop(i), curr_subset + [curr], target - curr)
      end
    end
  end
end

arr = [1, 3, 4, 5, 6, 15]
0.upto(arr.size - 1) do |i|
  solve(arr[i..arr.size - 1], [], 15)
end
