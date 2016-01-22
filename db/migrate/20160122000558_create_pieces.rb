class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
      t.datetime :guarantee_start
      t.datetime :guarantee_expiry
      t.text :notes
      t.boolean :status, default: true

      t.timestamps null: false
    end
  end
end
