class AddLabelindexToCaseweights < ActiveRecord::Migration
  def change
    add_column :caseweights, :labelindex, :integer
  end
end
