class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.string :name
      t.integer :user_id
      t.string :model
      t.string :pn
      t.string :note

      t.timestamps
    end
  end
end
