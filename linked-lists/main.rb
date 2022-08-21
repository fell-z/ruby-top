# Linked list Implementation
class LinkedList
  attr_reader :head, :tail

  # Object that stores data and a link to the next Node object
  class Node
    attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end

    def to_s
      "( #{@value} )"
    end
  end

  def initialize(head = nil, second = nil, *rest)
    @head = head.nil? ? nil : Node.new(head)
    @tail = second.nil? ? nil : Node.new(second)
    @head.next_node = @tail unless @head.nil?
    rest.each do |value|
      append(value)
    end
  end

  def append(value)
    return fill_head(value) if @head.nil?

    new_tail = Node.new(value)
    if @tail.nil? || @tail == @head
      @head.next_node = new_tail
    else
      @tail.next_node = new_tail
    end
    @tail = new_tail
    value
  end

  def prepend(value)
    return fill_head(value) if @head.nil?

    new_head = Node.new(value, @head)
    @head = new_head
    @tail = @head.next_node if @tail.nil?
    value
  end

  def insert_at(value, index)
    prior_node = at(index - 1)
    posterior_node = at(index)

    prior_node.next_node = Node.new(value, posterior_node)
    value
  end

  def remove_at(index)
    prior_node = at(index - 1)
    removed_node_value = at(index).value

    prior_node.next_node = at(index + 1)
    removed_node_value
  end

  def contains?(value)
    current_node = @head
    size.times do
      break if current_node.value == value

      current_node = current_node.next_node
    end
    current_node.value == value
  rescue StandardError
    false
  end

  def find(value)
    current_node = @head
    index = size.times do |time|
      break time if current_node.value == value

      current_node = current_node.next_node
    end
    (current_node.value == value) ? index : nil
  rescue StandardError
    nil
  end

  def pop
    prior_node = at(size - 2)
    removed_node_value = prior_node.next_node.value
    @tail = prior_node
    prior_node.next_node = nil
    removed_node_value
  rescue StandardError
    nil
  end

  def at(index)
    current_node = @head
    index.times do
      current_node = current_node.next_node
    end
    current_node
  rescue StandardError
    nil
  end

  def size
    calc_size
  end

  def to_s
    nodes_as_string
  end

  private

  def nodes_as_string(node = @head)
    return "nil" if node.nil?

    "#{node} -> " + nodes_as_string(node.next_node)
  end

  def fill_head(value)
    @head = Node.new(value, @tail)
    value
  end

  def calc_size(root = @head)
    return 0 if root.nil?

    1 + calc_size(root.next_node)
  end
end
