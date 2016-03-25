class CreateReportsPieces < ActiveRecord::Migration
  def change
    create_table :pieces_reports, :id => false do |t|
	t.belongs_to :report, index: true
	t.belongs_to :piece, index: true
	t.text	:note
	t.boolean :status
    end
  end
end
