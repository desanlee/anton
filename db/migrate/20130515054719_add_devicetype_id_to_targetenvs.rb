class AddDevicetypeIdToTargetenvs < ActiveRecord::Migration
  def change
    add_column :targetenvs, :devicetype_id, :integer
  end
end
