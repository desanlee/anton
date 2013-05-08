class CreateDevicetypes < ActiveRecord::Migration
  def change
    create_table :devicetypes do |t|
      t.string :name
      t.integer :user_id
      t.string :positionname
      t.string :note

      t.timestamps
    end
  end
end
