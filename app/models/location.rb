class Location < ActiveRecord::Base

	has_closure_tree

	has_many :pieces

end
