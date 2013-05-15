class CreateTargetcases < ActiveRecord::Migration
  def change
    create_table :targetcases do |t|
      t.integer :target_id
      t.string :casetype
      t.integer :casepara

      t.timestamps
    end
  end
end
