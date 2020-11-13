require_relative 'node'

class Tree
  attr_accessor :sorted_array, :root

  def initialize(arr)
    @sorted_array = arr.sort.uniq

    @root = build_tree(sorted_array)
  end
end
