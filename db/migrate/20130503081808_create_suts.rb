class CreateSuts < ActiveRecord::Migration
  def change
    create_table :suts do |t|
      t.string :name
      t.integer :user_id
      t.integer :system_id
      t.string :spip
      t.string :note

      t.timestamps
    end
  end
end
