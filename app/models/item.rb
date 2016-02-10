class Item < ActiveRecord::Base

	belongs_to :category
	belongs_to :unit
	belongs_to :location
	has_many :pieces

	validates :name, presence: true,
			length: { minimum: 3}

	self.per_page = 10
end
