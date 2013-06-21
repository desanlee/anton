class AddDevicepositionToTargetenvrelationships < ActiveRecord::Migration
  def change
    add_column :targetenvrelationships, :deviceposition, :integer
  end
end
