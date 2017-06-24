# https://www.interviewbit.com/problems/word-search-board/
class Node
  def initialize(val, x, y)
    @val = val
    @x = x
    @y = y
  end

  def val
    @val
  end

  def x
    @x
  end

  def y
    @y
  end

  def inspect
    "#{@val} (#{@x}, #{@y})"
  end

  def to_s
    inspect
  end

  def ==(o)
    o.class == self.class && o.state == state
  end

  def eql?(other_key)
    state == other_key.state
  end

  def hash
    state.hash
  end

  protected

  def state
    [@val, @x, @y]
  end
end

class Solution
  def initialize
    @graph = {}
    @debug = false
  end

  # @param a : array of strings eg ["ABCE", "SFCS", "ADEE"]
  # @param b : string
  # @return an integer
  def exist(strings, tst)
    strings.each_with_index do |str, i|
      str.chars.each_with_index do |char, j|
        top = Node.new(strings[i - 1][j], j, i - 1) if i > 0
        left = Node.new(str[j - 1], j - 1, i) if j > 0
        right = Node.new(str[j + 1], j + 1, i) if j < str.length - 1
        bottom = Node.new(strings[i + 1][j], j, i + 1) if i < strings.length - 1
        @graph[Node.new(char, j, i)] = [top, left, right, bottom].compact
      end
    end
    puts "#{@graph}" if @debug
    if check_graph(tst)
      return "1"
    else
      return "0"
    end
  end

  def check_graph(tst)
    @graph.each do |node, neighbors|
      if node.val == tst[0]
        # found a root for the graph
        tail = tst[1..-1]
        puts "found graph root #{node}, recursing..." if @debug
        return true if recurse(neighbors, tail)
      end
    end
    return false
  end

  def recurse(neighbors, str)
    return true if str.empty?
    return false if neighbors.nil? || neighbors.empty?
    puts "looking for neighbor #{str[0]}" if @debug
    return neighbors.select { |n| n.val == str[0] }.any? do |neighbor|
      if neighbor
        puts "found neighbor #{neighbor}" if @debug
        recurse(@graph[neighbor], str[1..-1])
      else
        false
      end
    end
  end
end

# arr = ["ABCE", "SFCS", "ADEE"]
# Solution.new.exist(arr, "ABCCED")
# Solution.new.exist(arr, "SEE")
# Solution.new.exist(arr, "ABCB")
# Solution.new.exist(arr, "ABFSAB")
# Solution.new.exist(arr, "ABCD")
