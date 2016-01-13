class Removetagcoloumnfromcategory < ActiveRecord::Migration
  def change
	remove_column :categories, :tag  
  end
end
