require_relative "main"

tree = Tree.new(Array.new(15) { rand(1..100) })

def print_elements(tree)
  puts "Level order: #{tree.level_order}"
  puts "Preorder: #{tree.preorder}"
  puts "Postorder: #{tree.postorder}"
  puts "Inorder: #{tree.inorder}"
end

puts "The tree is balanced? #{tree.balanced? ? 'Yes' : 'No'}"

puts "Now, printing elements...\n\n"
print_elements(tree)

puts "Now inserting several numbers greater than 100 and less than 200."
15.times do
  tree.insert(rand(100..200))
end

puts "The tree is unbalanced? #{!tree.balanced? ? 'Yes' : 'No'}"
puts "Now rebalancing..."
tree.rebalance
puts "Now, is the tree balanced? #{tree.balanced? ? 'Yes' : 'No'}"

puts "Now, printing elements again...\n\n"
print_elements(tree)
