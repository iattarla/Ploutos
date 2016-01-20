require "administrate/base_dashboard"

class LocationDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    parent: Field::BelongsTo.with_options(class_name: "Location"),
    children: Field::HasMany.with_options(class_name: "Location"),
    ancestor_hierarchies: Field::HasMany.with_options(class_name: "LocationHierarchy"),
    self_and_ancestors: Field::HasMany.with_options(class_name: "Location"),
    descendant_hierarchies: Field::HasMany.with_options(class_name: "LocationHierarchy"),
    self_and_descendants: Field::HasMany.with_options(class_name: "Location"),
    id: Field::Number,
    name: Field::String,
    code: Field::String,
    parent_id: Field::Number,
    sort_order: Field::Number,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :parent,
    :children,
    :ancestor_hierarchies,
    :self_and_ancestors,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = ATTRIBUTE_TYPES.keys

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :parent,
    :children,
    :ancestor_hierarchies,
    :self_and_ancestors,
    :descendant_hierarchies,
    :self_and_descendants,
    :name,
    :code,
    :parent_id,
    :sort_order,
  ]

  # Overwrite this method to customize how locations are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(location)
  #   "Location ##{location.id}"
  # end
end
