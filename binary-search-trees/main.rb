# Binary Search Tree implementation
class Tree
  attr_reader :root

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

  def initialize(arr)
    @root = build_tree(arr)
  end

  def insert(value, node = @root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end

    node
  end

  def inorder(node = @root, arr = [], &block)
    return if node.nil?

    inorder(node.left, arr, &block)
    if block_given?
      yield node
    else
      arr << node.data
    end
    inorder(node.right, arr, &block)

    return arr unless block_given?

    nil
  end

  private

  def build_tree(arr)
    return if arr.empty?

    arr = arr.sort.uniq
    mid_point = arr.length / 2
    Node.new(
      arr[mid_point],
      build_tree(arr[0, mid_point]),
      build_tree(arr[mid_point + 1, arr.length])
    )
  end
end
