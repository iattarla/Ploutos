class AddAbbreviationToUnits < ActiveRecord::Migration
  def change
    add_column :units, :abbr, :string
  end
end
