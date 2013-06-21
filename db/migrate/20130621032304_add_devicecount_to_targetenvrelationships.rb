class AddDevicecountToTargetenvrelationships < ActiveRecord::Migration
  def change
    add_column :targetenvrelationships, :devicecount, :integer
  end
end
