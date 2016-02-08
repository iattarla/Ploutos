class AddPriceAndDeliveryDateToItems < ActiveRecord::Migration
  def change
	add_column :items, :price, :decimal
	add_column :items, :delivery_date, :datetime
	add_column :pieces, :delivery_date, :datetime
  end
end
