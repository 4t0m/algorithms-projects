require 'binary_search_tree'

describe BinarySearchTree do
	let (:tree) { BinarySearchTree.new }
	let (:node0) { BSTNode.new(0) }
	let (:node1) { BSTNode.new(1) }
	let (:node2) { BSTNode.new(2) }
	let (:node3) { BSTNode.new(3) }
	let (:node4) { BSTNode.new(4) }
	let (:node5) { BSTNode.new(5) }

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

		it "does not find an element in empty tree" do
			expect(tree.find(1)).to be false
		end

		it "does not find an element that has not been inserted" do
			tree.insert(node2)

			expect(tree.find(1)).to be false
		end
	end

	context "deletion" do 
		it "deletes a node with no children" do 
			tree.insert(node2)
			tree.insert(node1)
			tree.delete(1)

			expect(node2.left).to be_nil
		end
	
		it "deletes a node with one child" do
			tree.insert(node3)
			tree.insert(node2)
			tree.insert(node1)
			tree.delete(2)

			expect(node3.left).to eq(node1)
		end

		it "deletes the root node and sets a new root" do
			tree.insert(node2)
			tree.insert(node1)
			tree.delete(2)

			expect(tree.root).to eq(node1)
		end

		it "deletes a node with two children and promotes children as required" do
			tree.insert(node4)
			tree.insert(node0)
			tree.insert(node5)
			tree.insert(node3)
			tree.insert(node1)
			tree.insert(node2)
			tree.delete(4)

			expect(node3.left).to eq(node0)
			expect(node0.right).to eq(node1)
		end

		it "returns false when given value is not in tree" do
			expect(tree.delete(2)).to be false
		end
	end
end
