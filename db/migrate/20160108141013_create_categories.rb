class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
	
	t.string :name, null: false
	t.integer :tag
	t.integer :parent_id
	t.integer :sort_order
      t.timestamps null: false
    end
  end
end
