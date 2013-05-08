class AddDeviceIdToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :device_id, :integer
  end
end
