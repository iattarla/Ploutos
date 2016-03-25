class Report < ActiveRecord::Base

  belongs_to :users
  has_many :pieces_report
  has_many :pieces, through: :pieces_report
end
