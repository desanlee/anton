class AddTargetindexToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :targetindex, :integer
  end
end
