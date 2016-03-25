class DeleteSerialNoFromItem < ActiveRecord::Migration
  def change
	remove_column :items, :serial_no
  end
end
