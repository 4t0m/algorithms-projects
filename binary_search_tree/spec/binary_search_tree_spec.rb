require 'binary_search_tree'

describe BinarySearchTree do
	let (:tree) { BinarySearchTree.new }
	let (:node1) { BSTNode.new(1) }
	let (:node2) { BSTNode.new(2) }
	let (:node3) { BSTNode.new(3) }
	let (:node4) { BSTNode.new(4) }

	context "initialization" do
		it "sets root to nil" do
			expect(tree.root).to eq(nil)
		end
	end


	context "insertion" do
		it "sets first inserted node as root" do
			tree.insert(node2)
			expect(tree.root).to eq(node2)
		end

		it "inserts elements on the correct side of the root" do
			tree.insert(node2)
			tree.insert(node1)
			tree.insert(node3)

			expect(node2.left).to eq(node1)
			expect(node2.right).to eq(node3)
		end

		it "inserts elements recursively" do
			tree.insert(node2)
			tree.insert(node1)
			tree.insert(node3)
			tree.insert(node4)
			expect(node3.right).to eq(node4)
		end
	end
end
