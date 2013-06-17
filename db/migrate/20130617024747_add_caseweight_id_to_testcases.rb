class AddCaseweightIdToTestcases < ActiveRecord::Migration
  def change
    add_column :testcases, :caseweight_id, :integer
  end
end
