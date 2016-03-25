class AddTypeAndOwnerFieldToItems < ActiveRecord::Migration
  def change
	add_column :items, :kind, :string, :limit => 1
	add_column :items, :owner, :string
  end

  def data
    Item.find_each do |item|
      item.kind = item.serial_no[0]
      item.owner = item.serial_no[1..3]

      item.save!
    end
  end
end
