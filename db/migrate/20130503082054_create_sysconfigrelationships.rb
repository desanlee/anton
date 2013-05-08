class CreateSysconfigrelationships < ActiveRecord::Migration
  def change
    create_table :sysconfigrelationships do |t|
      t.integer :sysconfig_id
      t.integer :device_id
      t.integer :position
      t.integer :user_id

      t.timestamps
    end
  end
end
