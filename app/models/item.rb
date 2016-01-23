class Item < ActiveRecord::Base

	belongs_to :category
	has_many :pieces

	validates :name, presence: true,
			length: { minimum: 5} 

end
