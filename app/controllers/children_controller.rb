class ChildrenController < ApplicationController



	def get
		p params
		@class = params[:which]
		@form = params[:form]
		@categories = Category.find(params[:id]).children
		respond_to do |format|
			format.js
    		end
	end


end
