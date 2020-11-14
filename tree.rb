require_relative 'node'

class Tree
  attr_accessor :sorted_array, :root

  def initialize(arr)
    @sorted_array = arr.sort.uniq

    @root = build_tree sorted_array
  end

  def build_tree(sorted)
    return nil if sorted.empty?

    midpoint = sorted.length / 2

    root_node = Node.new sorted[midpoint]

    root_node.left = build_tree sorted[0...midpoint]

    root_node.right = build_tree sorted[midpoint + 1..-1]

    root_node
  end

  def insert(value)
    new_node = Node.new value

    temp = root

    loop do
      break if new_node == temp

      if new_node > temp
        (temp.right = new_node; break) if temp.right.nil?

        temp = temp.right
      else
        (temp.left = new_node; break) if temp.left.nil?

        temp = temp.left
      end
    end
  end

  def find(val)
    temp = root

    find_helper temp, val
  end

  def level_order
    queue = [root]

    values = []

    until queue.empty?

      node = queue.shift

      values << node.value

      queue << node.left unless node.left.nil?

      queue << node.right unless node.right.nil?

    end

    values
  end

  def inorder
    inorder_helper root
  end

  def preorder
    preorder_helper root
  end

  def postorder
    postorder_helper root
  end

  # Provided at https://www.theodinproject.com/courses/ruby-programming/lessons/binary-search-trees
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"

    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def find_helper(node, value)
    return nil if node.nil?

    return node if node.value == value

    value > node.value ? find_helper(node.right, value) : find_helper(node.left, value)
  end

  def inorder_helper(node)
    return [] if node.nil?

    inorder_helper(node.left) + [node.value] + inorder_helper(node.right)
  end

  def preorder_helper(node)
    return [] if node.nil?

    [node.value] + preorder_helper(node.left) + preorder_helper(node.right)
  end

  def postorder_helper(node)
    return [] if node.nil?

    postorder_helper(node.left) + postorder_helper(node.right) + [node.value]
  end
end

t = Tree.new [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 7000, 7000]
t.insert 10_000
t.insert 2
t.insert 10_000

t.pretty_print

p t.find 7000
p t.find 324
p t.find 9_000_000

p t.level_order

p t.inorder
p t.preorder
p t.postorder
