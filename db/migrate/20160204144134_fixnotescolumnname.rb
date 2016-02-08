class Fixnotescolumnname < ActiveRecord::Migration
  def change
	rename_column :items, :note, :description
  end
end
