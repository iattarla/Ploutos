class Item < ActiveRecord::Base

	belongs_to :category
	belongs_to :unit
	has_many :pieces

	validates :name, presence: true,
			length: { minimum: 5} 

end
