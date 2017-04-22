class BSTNode
  attr_accessor :val

  def initialize(val)
    @val = val
    @parent = nil
    @left = nil
    @right = nil
  end
end
