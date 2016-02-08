class AddSerialNoToPieces < ActiveRecord::Migration
  def change
	add_column :pieces, :serial_no, :string
  end
end
