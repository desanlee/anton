class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :devicecate
      t.integer :devicetype_id
      t.integer :user_id
      t.string :name
      t.integer :countnum
      t.string :model
      t.string :pn
      t.string :note

      t.timestamps
    end
  end
end
