class AddStatusToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :status, :integer
  end
end
