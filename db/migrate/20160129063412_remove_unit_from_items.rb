class RemoveUnitFromItems < ActiveRecord::Migration
  def change
  remove_column :items, :unit, :string

  change_table :items do |t|
      t.belongs_to :unit, index: true
    end

  end
end
