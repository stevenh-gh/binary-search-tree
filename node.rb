class Node
  include Comparable

  attr_accessor :value, :left, :right

  def <=>(other)
    value <=> other.value
  end

  def initialize(val = nil)
    @value = val

    @left = nil

    @right = nil
  end
end
