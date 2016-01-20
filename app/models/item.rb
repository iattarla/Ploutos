class Item < ActiveRecord::Base

	belongs_to :category

	validates :name, presence: true,
			length: { minimum: 5} 

end
