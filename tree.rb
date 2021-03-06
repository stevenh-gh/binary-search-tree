require 'pry'
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

  def delete(node)
    # if node is leaf

    delete_leaf node if node.left.nil? && node.right.nil?

    # if node has 1 child

    delete_one_child node if node.left.nil? ^ node.right.nil?

    # if node has 2 children

    delete_two_child node if !node.left.nil? && !node.right.nil?
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

  def depth(node) # Length of path from root to node
    depth_helper root, node
  end

  def height(node)
    return 0 if node.nil? || (node.left.nil? && node.right.nil?)

    left = height(node.left)

    right = height(node.right)

    left > right ? left + 1 : right + 1
  end

  def balanced?
    balance_helper root
  end

  def rebalance
    self.root = build_tree level_order.sort
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

  def depth_helper(root, node)
    return 0 if root.nil? || root == node

    node > root ? depth_helper(root.right, node) + 1 : depth_helper(root.left, node) + 1
  end

  def balance_helper(node)
    node.nil? || (

      balance_helper(node.left) &&

      balance_helper(node.right) &&

      (height(node.left) - height(node.right)).abs < 2

    )
  end

  def delete_leaf(node)
    temp = root

    until temp.nil?
      (temp.right = nil; break) if temp.right == node

      (temp.left = nil; break) if temp.left == node

      temp = node > temp ? temp.right : temp.left
    end
  end

  def delete_one_child(node)
    parent = nil

    current = root

    child = nil

    loop do
      parent = current

      current = if node > current

                  current.right

                else

                  current.left

                end

      next unless current == node

      child = [current.right, current.left].select { |node| !node.nil? }[0]

      parent.left = child if parent.left == current

      parent.right = child if parent.right == current

      break
    end
  end

  def delete_two_child(node)
    delete_node = root

    delete_node_parent = nil

    loop do
      if delete_node == node

        # get left and right child

        delete_node_left = delete_node.left

        delete_node_right = delete_node.right

        # get inorder successor (down right node and all the way to the left)

        successor = delete_node_right

        # if right child is a not leaf

        if !delete_node_right.right.nil? && !delete_node_right.left.nil?

          successor_parent = nil

          until successor.left.nil?

            successor_parent = successor

            successor = successor.left

          end

          # after getting successor and its parent, set parent left child to nil

          successor_parent.left = nil

        end

        # set successor's left and right child

        successor.left = delete_node_left

        successor.right = delete_node_right == successor ? nil : delete_node_right

        # if node not root, then set parent of node's child to be successor

        unless node == root

          delete_node_parent.left = successor if delete_node_parent.left == node

          delete_node_parent.right = successor if delete_node_parent.right == node

        end

        self.root = successor if node == root

        break

      end

      delete_node_parent = delete_node

      delete_node = node > delete_node ? delete_node.right : delete_node.left
    end
  end
end
