class ItemsController < ApplicationController


	before_action :authenticate_user!


	def index
		@items = Item.all
	end

	
	def new
		@item = Item.new	
		@categories = Category.roots
	end
		
	def create
	#	render plain: params[:items].inspect
	
		@item = Item.new(create_params)
	
		if @item.save
	
			redirect_to @item
		else
			render 'new'
		end
	end

	def edit
		
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])

		if @item.update(item_params)
			redirect_to @item
		else
			render 'edit'
		end
	end
	
	def show
		@item = Item.find(params[:id])
		@path = @item.category.ancestry_path
		@qr = RQRCode::QRCode.new(@item.name).to_img.resize(200, 200).to_data_url 
	end
	
	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		redirect_to items_path
	end


  private
  def item_params
	params.require(:item).permit(:name, :note)
  end

  def create_params
	data = params.require(:item).permit(:name, :note)
	category_id = params.require(:category).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last
	p category_id
	return data.merge(Hash["category_id" => category_id ])
  end


end
