require_relative 'node'

class Tree
  attr_accessor :sorted_array, :root

  def initialize(arr)
    @sorted_array = arr.sort.uniq

    @root = build_tree(sorted_array)
  end

  def build_tree(sorted)
    return nil if sorted.empty?

    midpoint = sorted.length / 2

    root_node = Node.new(sorted[midpoint])

    root_node.left = build_tree(sorted[0...midpoint])

    root_node.right = build_tree(sorted[midpoint + 1..-1])

    root_node
  end

  # Provided at https://www.theodinproject.com/courses/ruby-programming/lessons/binary-search-trees
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right

    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"

    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

t = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324, 7000, 7000])
p t.sorted_array
t.pretty_print
