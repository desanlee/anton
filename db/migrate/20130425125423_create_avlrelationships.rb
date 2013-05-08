class CreateAvlrelationships < ActiveRecord::Migration
  def change
    create_table :avlrelationships do |t|
      t.integer :system_id
      t.integer :device_id
      t.integer :user_id
      t.integer :maxnum
      t.string :note

      t.timestamps
    end
  end
end
