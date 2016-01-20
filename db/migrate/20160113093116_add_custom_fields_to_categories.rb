class AddCustomFieldsToCategories < ActiveRecord::Migration
  def change

  	add_column :categories, :custom_fields, :string, :limit => 4096

  end
end
