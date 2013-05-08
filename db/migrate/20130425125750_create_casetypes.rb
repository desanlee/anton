class CreateCasetypes < ActiveRecord::Migration
  def change
    create_table :casetypes do |t|
      t.string :name
      t.integer :user_id
      t.string :note

      t.timestamps
    end
  end
end
