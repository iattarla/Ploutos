class PiecesReport < ActiveRecord::Base
  belongs_to :piece
  belongs_to :report
end
