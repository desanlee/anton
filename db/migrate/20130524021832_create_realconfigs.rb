class CreateRealconfigs < ActiveRecord::Migration
  def change
    create_table :realconfigs do |t|
      t.integer :targetmatrix_id
      t.integer :device_id
      t.string :devicename
      t.integer :devicetype

      t.timestamps
    end
  end
end
