class RemoveTargetcaseIdToTargetcaserelationships < ActiveRecord::Migration
  def up
    remove_column :targetcaserelationships, :targetcase_id
  end

  def down
    add_column :targetcaserelationships, :targetcase_id, :integer
  end
end
