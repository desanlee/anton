class AddTargetenvIdToTargetcaserelationships < ActiveRecord::Migration
  def change
    add_column :targetcaserelationships, :targetenv_id, :integer
  end
end
