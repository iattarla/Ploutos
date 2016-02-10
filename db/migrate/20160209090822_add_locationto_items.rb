class AddLocationtoItems < ActiveRecord::Migration
  def change	

  	change_table :items do |t|
                t.belongs_to :location, index: true
        end

  end
end
