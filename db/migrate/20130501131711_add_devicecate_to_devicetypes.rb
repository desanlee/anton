class AddDevicecateToDevicetypes < ActiveRecord::Migration
  def change
    add_column :devicetypes, :devicecate, :string
  end
end
