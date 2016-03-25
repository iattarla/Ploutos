class Piece < ActiveRecord::Base

	belongs_to :item
	belongs_to :user
	belongs_to :location
	has_many :pieces_reports
  has_many :reports, through: :pieces_reports


	def stockno
		"#{self.item.stockno}-#{id}"
	end

end
