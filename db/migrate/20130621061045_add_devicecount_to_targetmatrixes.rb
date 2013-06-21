class AddDevicecountToTargetmatrixes < ActiveRecord::Migration
  def change
    add_column :targetmatrices, :devicecount, :integer
  end
end
