class AddMoreFieldsToItem < ActiveRecord::Migration
  def change
    add_column :items, :brand, :string 
    add_column :items, :model, :string 
    add_column :items, :unit, :string
    add_column :items, :serial_no, :string
  end
end
