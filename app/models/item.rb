class Item < ActiveRecord::Base

	belongs_to :category
	belongs_to :unit
	has_many :pieces
	accepts_nested_attributes_for :pieces, allow_destroy: true

	validates :name, presence: true,
			length: { minimum: 3}

	self.per_page = 20

	scope :category, -> (category_id) { where category_id: category_id }

	def stockno
    "#{kind}#{owner}-#{id}"
  end

	def quantity
	#need to send quantity for the first creation
	end

	def location_id
	#need to send location for the first creation
	end
end
