class Addsubmittedtoreports < ActiveRecord::Migration
  def change
	add_column :reports, :submitted, :boolean, :default => false
  end
end
