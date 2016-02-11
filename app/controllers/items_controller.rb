class ItemsController < ApplicationController


	before_action :authenticate_user!


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
		@serial_no = set_serial_no
		@item = Item.new(create_params)

		if @item.save
			@item.update_columns(serial_no: @serial_no +"-"+ @item.id.to_s)

			if (params[:serial_no][:type] == "D")
				params[:item][:quantity].to_i.times do
					@piece = @item.pieces.build
					@piece.save
					@piece.update_columns(serial_no: @item.serial_no + "-" + @piece.id.to_s, location_id: @item.location_id)
				end
			elsif (params[:serial_no][:type] == "C")
					@piece = @item.pieces.build
					@piece.save
					@piece.update_columns(serial_no: @item.serial_no + "-" + @piece.id.to_s, location_id: @item.location_id)

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

		@item.destroy

		redirect_to items_path

	end


  private

	def create_params

		data = params.require(:item).permit(:name, :description, :brand, :model, :quantity, :unit_id, :price, :delivery_date, :location_id)

		category_id = params.require(:category).permit(:id1,:id2,:id3, :id4, :id5).values.reject(&:empty?).compact.last

		return data.merge(Hash["category_id" => category_id ])

	end

	def set_serial_no

		return params[:serial_no][:type] + params[:serial_no][:owner]
	end


end
