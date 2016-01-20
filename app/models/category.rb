class Category < ActiveRecord::Base

	has_many :items
	has_closure_tree

store :custom_fields

#def parents
#	self.parent_id
#end
#
#
#def parents=(value)
#	self.parent_id = value.compact.last
#end

end
