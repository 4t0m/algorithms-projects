require "bst_node"

describe BSTNode do 
	context "initialization" do
		it "sets val to nil by default" do
			default_node = BSTNode.new
			expect(default_node.val).to eq(nil)
		end

		it "sets val when given argument" do
			node = BSTNode.new(4)
			expect(node.val).to eq(4)
		end

		it "has accessors for left and right children" do
			node4 = BSTNode.new(4)
			node5 = BSTNode.new(5)
			node4.right = node5

			expect(node4.left).to eq(nil)
			expect(node4.right).to eq(node5)
		end
	end
end
