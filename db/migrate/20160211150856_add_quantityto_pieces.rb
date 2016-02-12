class AddQuantitytoPieces < ActiveRecord::Migration
  def change
	add_column :pieces, :quantity, :integer
  end
end
