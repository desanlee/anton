class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.integer :casetype_id
      t.string :casecate
      t.string :name
      t.integer :user_id
      t.string :steps
      t.integer :paradevicetype_id

      t.timestamps
    end
  end
end
