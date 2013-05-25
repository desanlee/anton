class AddEnvdeviceIdToTargetmatrixes < ActiveRecord::Migration
  def change
    add_column :targetmatrices, :envdevice_id, :integer
  end
end
