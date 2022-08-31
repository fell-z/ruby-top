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

  def level_order
    queue = [@root]
    arr = []

    until queue.empty?
      queue << queue[0].left unless queue[0].left.nil?
      queue << queue[0].right unless queue[0].right.nil?

      if block_given?
        yield queue.shift
      else
        arr << queue.shift.data
      end
    end

    return arr unless block_given?
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

    block_given? ? nil : arr
  end

  def preorder(node = @root, arr = [], &block)
    return if node.nil?

    if block_given?
      yield node
    else
      arr << node.data
    end
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)

    block_given? ? nil : arr
  end

  def postorder(node = @root, arr = [], &block)
    return if node.nil?

    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    if block_given?
      yield node
    else
      arr << node.data
    end

    block_given? ? nil : arr
  end

  def height(node)
    return 0 if node.nil?

    left_subtree_height = 1 + height(node.left)
    right_subtree_height = 1 + height(node.right)

    (left_subtree_height >= right_subtree_height) ? left_subtree_height : right_subtree_height
  end

  def depth(node)
    depth_counter = 1
    current_node = @root
    loop do
      break depth_counter if current_node.data == node.data

      current_node = (node.data < current_node.data) ? current_node.left : current_node.right

      depth_counter += 1
    end
  end

  def balanced?
    nodes = []
    level_order { |node| nodes << node }

    nodes.map! do |node|
      left_subtree_height = height(node.left)
      right_subtree_height = height(node.right)

      (left_subtree_height - right_subtree_height).between?(-1, 1)
    end

    nodes.all?
  end

  def rebalance
    arr = inorder
    @root = build_tree(arr)
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
