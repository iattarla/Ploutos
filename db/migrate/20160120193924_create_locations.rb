class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :code
      t.integer :parent_id
      t.integer :sort_order


      t.timestamps null: false
    end
  end
end
