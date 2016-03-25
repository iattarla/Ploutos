class ItemModelDataFixes < ActiveRecord::Migration
  def data
    Item.find_each do |item|
      if item.kind == "C" && !item.pieces.first.blank?
        piece = item.pieces.first
        piece.quantity = item.quantity
        piece.save!
      end
    end
  end
end

class ItemModelSomeFixes < ActiveRecord::Migration

  def change
#    remove_column :items, :quantity
    remove_belongs_to :items, :location
  end

end
