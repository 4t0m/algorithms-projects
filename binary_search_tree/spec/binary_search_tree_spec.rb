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

		it "inserts duplicate elements" do
			tree.insert(node2)
			tree.insert(node1)
			tree.insert(node1)
		
			expect(node1.left).to eq(node1)
		end
	end

	context "find" do
		it "finds the value of the root element" do
			tree.insert(node2)
			expect(tree.find(2)).to be true
		end

		it "finds elementns on the left and right" do
			tree.insert(node2)
			tree.insert(node1)
			tree.insert(node3)
			
			expect(tree.find(1)).to be true
			expect(tree.find(3)).to be true
		end

		it "finds elements recursively" do
			tree.insert(node2)
			tree.insert(node1)
			tree.insert(node3)
			tree.insert(node4)

			expect(tree.find(4)).to be true
		end

		it "does not find an element that has not been inserted" do
			expect(tree.find(1)).to be false
		end
	end
end
