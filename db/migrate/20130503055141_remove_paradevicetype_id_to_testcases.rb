class RemoveParadevicetypeIdToTestcases < ActiveRecord::Migration
  def up
    remove_column :testcases, :paradevicetype_id
  end

  def down
    add_column :testcases, :paradevicetype_id, :integer
  end
end
