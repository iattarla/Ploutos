class AddCategoryToItems < ActiveRecord::Migration
  def change
	change_table :items do |t|
		t.belongs_to :category, index: true
	end

  end
end
