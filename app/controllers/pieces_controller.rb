class PiecesController < ApplicationController
  layout "piece_filter", only: [:pieces]
  before_action :authenticate_user!, except: [:print]
  before_action :set_piece, only: [:show, :edit, :update, :destroy]
  before_action :set_searching


  def pieces

    if params[:grid] && params[:grid][:items]
      @selected = Item.find(params[:grid][:items])
      @pieces_grid = initialize_grid(Piece,
        include: [:item, :item, {item: :category}],
        conditions: { item: @selected },
        order: 'id',
        per_page: 20
        )
    else
      @pieces_grid = initialize_grid(Piece,
        include: [:item, :location, :user, {item: :category}],
        order: 'id',
        per_page: 20
        )
    end
    @items = Item.order('created_at DESC').page(params[:page])
    @categories = Category.roots

  end

  def qzprint
    if params[:grid] && params[:grid][:pieces]
      @print = Piece.find(params[:grid][:pieces])
    end
  end

  # GET /pieces
  # GET /pieces.json
  def index
    @item = Item.find(params[:item_id])
    @pieces = @item.pieces
  end

  # GET /pieces/1
  # GET /pieces/1.json
  def show
    @item = Item.find(params[:item_id])
    @piece = @item.pieces.find(params[:id])
    @qr = RQRCode::QRCode.new(@piece.stockno).to_img.resize(200, 200).to_data_url
  end

  # GET /pieces/1/print
  # GET /pieces/1/print.json
  def print
    @item = Item.find(params[:item_id])
    @piece = @item.pieces.find(params[:id])
    @qr = RQRCode::QRCode.new("http://192.168.14.175:3000/items/"+@item.id.to_s+"/pieces/"+@piece.id.to_s).to_img.resize(150,150).to_data_url

    respond_to do |format|
      format.html do
        render :layout => false
      end
      format.pdf do
        render pdf: "asd", :formats => [:html],
                            grayscale: true,
                            lowquality: true,
                            print_media_type: true,
                            orientation: 'Landscape',
                            page_height: 115,
                            page_width:47,
                            margin: { top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,}
      end
    end

  end

  # GET /pieces/new
  def new
    @item = Item.find(params[:item_id])
    @piece = Piece.new(:item => @item)
    @users = User.all
    @locations = Location.all
  end

  # GET /pieces/1/edit
  def edit
    @item = Item.find(params[:item_id])
    @piece = @item.pieces.find(params[:id])
    @users = User.all
    @locations = Location.all

  end

  # POST /pieces
  # POST /pieces.json
  def create
    @item = Item.find(params[:item_id])
    @error = false
    @users = User.all
    @locations = Location.all

    if @item.stockno.start_with?("D")
    	params[:piece][:quantity].to_i.times do

		@piece = @item.pieces.create(piece_params)

    	    	if @piece.save
    	    		#@piece.update_columns(serial_no: @piece.item.serial_no + "-" + @piece.id.to_s)
    	    	else
    	    		@error=true
       		end
    	end
    else

		@piece = @item.pieces.create(piece_params)

		if @piece.save
    	    		#@piece.update_columns(serial_no: @piece.item.serial_no + "-" + @piece.id.to_s)
    	    	else
    	    		@error=true
    	   		end


    end

    respond_to do |format|

	if !@error
		format.html { redirect_to([@item, @piece], notice: 'Piece was successfully created.') }
       		format.json { render :show, status: :created, location: @piece }
	else
		format.html { render :new }
        	format.json { render json: @piece.errors, status: :unprocessable_entity }
	end

    end
  end

  # PATCH/PUT /pieces/1
  # PATCH/PUT /pieces/1.json
  def update
    @item = Item.find(params[:item_id])
    @piece = @item.pieces.find(params[:id])


    respond_to do |format|
      if @piece.update(piece_params)
        format.html { redirect_to([@item, @piece], notice: 'Piece was successfully updated.') }
        format.json { render :show, status: :ok, location: @piece }
      else
        format.html { render :edit }
        format.json { render json: @piece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pieces/1
  # DELETE /pieces/1.json
  def destroy
    @piece.destroy
    respond_to do |format|
      format.html { redirect_to item_pieces_url, notice: 'Piece was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_piece
      @piece = Piece.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def piece_params
      params.require(:piece).permit(:guarantee_start, :guarantee_expiry, :serial_no,:notes, :status, :user_id, :location_id, :quantity)
    end

  	def set_searching
  		@q = Item.ransack(params[:q])
  	end
end
