class ChildrenController < ApplicationController



	def get
		@class = params[:which]
		@form = params[:form]
		@categories = Category.find(params[:id]).children
		respond_to do |format|
			format.js
    end
	end

	def fill
		@category = Category.find(params[:id])
		@categories = @category.self_and_ancestor_ids.reverse

		respond_to do |format|
			format.js
		end
	end

end
