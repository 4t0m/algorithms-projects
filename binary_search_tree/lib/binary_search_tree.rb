require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def find(el)
		find_helper(@root, el)
  end

  def insert(el)
		return @root = el if @root == nil
		insert_helper(@root, el)
		el
  end

  def delete(el)
  end

  def is_balanced?
  end

  def in_order_traversal
  end

  def maximum
  end

  def depth
  end

	private 
	def insert_helper(current_root, el)
		if el.val <= current_root.val
			if current_root.left == nil
				current_root.left = el
			else
				insert_helper(current_root.left, el)
			end
		elsif el.val > current_root.val
			if current_root.right == nil
				current_root.right = el
			else
				insert_helper(current_root.right, el)
			end
		end
	end

	def find_helper(current_root, el)
		return false unless current_root

		current_root.val == el || find_helper(current_root.left, el) || find_helper(current_root.right, el)
	end
end
