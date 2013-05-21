class AddDeviceIdToTaskobjects < ActiveRecord::Migration
  def change
    add_column :taskobjects, :device_id, :integer
  end
end
