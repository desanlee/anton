class AddDevicepositionToTargetmatrixes < ActiveRecord::Migration
  def change
    add_column :targetmatrices, :deviceposition, :integer
  end
end
