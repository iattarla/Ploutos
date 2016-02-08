class AddAssociationsForPieceModel < ActiveRecord::Migration
  def change
	
	change_table :pieces do |t|
		  t.belongs_to :item, index:true
		  t.belongs_to :user, index:true
		  t.belongs_to :location, index:true
	end
  
  
  end
end
