class AddDevicetypeIdToTestcases < ActiveRecord::Migration
  def change
    add_column :testcases, :devicetype_id, :integer
  end
end
