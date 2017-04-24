class BSTNode
  attr_accessor :val, :left, :right

  def initialize(val = nil)
    @val = val
    @parent = nil
    @left = nil
    @right = nil
  end
end
