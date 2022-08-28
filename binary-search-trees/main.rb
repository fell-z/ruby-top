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

  def delete(value, node = @root, prior_node = nil)
    # recursively get to the desired node to delete
    if value < node.data
      delete(value, node.left, node)
    elsif value > node.data
      delete(value, node.right, node)
    end

    # prevents the other recursive method calls from executing the rest of the procedure
    return unless value == node.data

    if node.left && node.right
      # why break works here?
      replacement_node = inorder(node.right) { |block_node| break block_node }

      node.data = replacement_node.data
      node.right = nil if node.right == replacement_node

      prior_node_to_replacement = inorder(node.right) do |block_node|
        break block_node if block_node.left == replacement_node
      end

      prior_node_to_replacement.left = replacement_node.right || nil
    # executes only if the node has one child
    elsif node.left
      node.data = node.left.data
      node.left = nil
    elsif node.right
      node.data = node.right.data
      node.right = nil
    # executes when there's no child
    else
      prior_node.left = nil if prior_node.left == node
      prior_node.right = nil if prior_node.right == node
    end
  rescue StandardError
    nil
  end

  def find(value, node = @root)
    return if node.nil?
    return node if value == node.data

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    end
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
