class RemoveDevicecateToDevices < ActiveRecord::Migration
  def up
    remove_column :devices, :devicecate
  end

  def down
    add_column :devices, :devicecate, :string
  end
end
