require_relative 'tree'

arr = Array.new(15) { rand(1..100) }

tree = Tree.new arr

tree.pretty_print

p "Is tree balanced?: #{tree.balanced?}"

p "Level order: #{tree.level_order}"

p "Preorder: #{tree.preorder}"

p "Postorder: #{tree.postorder}"

p "Inorder: #{tree.inorder}"

tree.insert 200
tree.insert 300
tree.insert 400
tree.insert 500
tree.insert 600

tree.pretty_print

p "Is tree balanced?: #{tree.balanced?}"

tree.rebalance

tree.pretty_print

p "Is tree balanced?: #{tree.balanced?}"

p "Level order: #{tree.level_order}"

p "Preorder: #{tree.preorder}"

p "Postorder: #{tree.postorder}"

p "Inorder: #{tree.inorder}"
