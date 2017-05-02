require 'binary_search_tree'

describe BinarySearchTree do
	let (:tree) { BinarySearchTree.new }

	context "initialization" do
		it "sets root to nil" do
			expect(tree.root).to eq(nil)
		end
	end
end
