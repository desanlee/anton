class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|
      t.integer :sysconfig_id
      t.integer :testcase_id
      t.integer :user_id
      t.string :result
      t.string :bug
      t.string :note

      t.timestamps
    end
  end
end
