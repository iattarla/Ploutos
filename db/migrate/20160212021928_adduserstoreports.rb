class Adduserstoreports < ActiveRecord::Migration
 def change
 
	change_table :reports do |t|
		t.belongs_to :user, index: true
	end

 end
end
