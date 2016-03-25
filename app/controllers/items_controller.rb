class ItemsController < ApplicationController


	before_action :authenticate_user!
  before_action :set_searching


	def index

		@items = Item.order('created_at DESC').page(params[:page])
		@categories = Category.roots

	end


	def new

		@item = Item.new

		@categories = Category.roots

		@units = Unit.all

		@locations = Location.all

	end

	def create

		@categories = Category.roots
		@units = Unit.all
		@item = Item.new(create_params)

		if @item.save

			if @item.kind == "D"
				params[:item][:quantity].to_i.times do
					@piece = @item.pieces.build
					@piece.save
					@piece.update_columns(location_id: params[:item][:location_id])
				end
			elsif @item.kind == "C"
					@piece = @item.pieces.build
					@piece.save
					@piece.update_columns(location_id: params[:item][:location_id], quantity: params[:item][:quantity])

			end

			redirect_to @item

		else

			render 'new'

		end

	end

	def edit

		@item = Item.find(params[:id])

		@categories = Category.roots

		@units = Unit.all

		@locations = Location.all

	end

	def update

		@item = Item.find(params[:id])

		@categories = Category.roots

		@units = Unit.all

		@locations = Location.all

		if @item.update(create_params)

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

		if !@item.pieces.empty?
			@item.pieces.destroy_all
		end
		@item.destroy

		redirect_to items_path

	end

	def report
		@categories = Category.all
		@items = Item.all.sort_by &(:category_id)

		respond_to do |format|
  		format.html # show.html.erb
			html = render_to_string(:action => 'report.html.erb', :layout => true)
  		format.pdf { render :text => PDFKit.new(html).to_pdf }
		end
	end

	def search
  	#@items = Item.all.page(params[:page])
		@items = @q.result.includes(:pieces).page(params[:page])
	end


  private

	def create_params

		data = params.require(:item).permit(:name, :kind, :owner, :description, :brand, :model, :unit_id, :price, :delivery_date)

		category_id = params.require(:category).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last

		return data.merge(Hash["category_id" => category_id ])

	end

	def set_serial_no

		return params[:serial_no][:type] + params[:serial_no][:owner]
	end

	def set_searching
		@q = Item.ransack(params[:q])
	end

end
