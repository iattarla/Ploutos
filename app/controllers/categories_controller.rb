class CategoriesController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_is_moderator, :except => [:items]
	before_action :set_searching


	def index
		@categories = Category.all
	end


	def new
		@category = Category.new
		@categories = Category.roots
	end

	def create

		@category = Category.new(create_params)

		if @category.save

			redirect_to categories_path
		else
			render 'new'
		end
	end

	def edit

		@category = Category.find(params[:id])
		@categories = Category.roots
	end

	def update
		@category = Category.find(params[:id])

		if @category.update(create_params)
			redirect_to categories_path
		else
			render 'edit'
		end
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		redirect_to categories_path
	end

	def show
		@category = Category.find(params[:id])
	end

	def items
		@category = Category.find(params[:id])
		@categories = @category.self_and_descendants.page(params[:page])
	end

	def set_item
		parent_id = set_item_params

		@category = Category.find(parent_id)

		redirect_to category_items_path(@category)
	end

#	def get_leaves
#
#		@class = params[:which]
#		@form = params[:form]
#		@categories = Category.find(params[:id]).children
#		respond_to do |format|
#			format.js
#    		end
#	end

  private
  def category_params
	 params.require(:category).permit(:name, :parent_id)

  end

  def create_params
	name = params.require(:category).permit(:name)
	parent_id = params.require(:parent).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last
	return name.merge(Hash["parent_id" => parent_id ])
  end

	def set_item_params
		return params.require(:category).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last
	end

	def set_searching
		@q = Item.ransack(params[:q])
	end


end
