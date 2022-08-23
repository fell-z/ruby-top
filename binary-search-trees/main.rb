class Tree
  # Tree node who stores data as well the left and right children nodes.
  class Node
    attr_accessor :data, :left, :right

    include Comparable

    def initialize(data, left = nil, right = nil)
      @data = data
      @left = left
      @right = right
    end

    def <=>(other)
      data <=> other.data
    rescue StandardError
      nil
    end
  end
end
