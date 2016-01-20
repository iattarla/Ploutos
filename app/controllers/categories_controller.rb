class CategoriesController < ApplicationController

	before_action :authenticate_user!
	before_action :verify_is_moderator

	def index
		@categories = Category.all
	end

	
	def new
		@category = Category.new	
		@categories = Category.roots
	end
	def edit
		
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])

		if @category.update(category_params)
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

	def create
	#	render plain: params[:items].inspect
		@category = Category.new(create_params)

		if @category.save
	
			redirect_to categories_path
		else
			render 'new'
		end
	end

	def get_leaves
	
		@class = params[:which]
		@form = params[:form]
		@categories = Category.find(params[:id]).children
		respond_to do |format|
			format.js
    		end
	end

  private
  def category_params
	 params.require(:category).permit(:name, :parent_id)
	
  end

  def create_params
	name = params.require(:category).permit(:name)
	parent_id = params.require(:parent).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last
	return name.merge(Hash["parent_id" => parent_id ])
  end


end
