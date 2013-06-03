class CreateTaskexecutions < ActiveRecord::Migration
  def change
    create_table :taskexecutions do |t|
      t.integer :task_id
      t.integer :execution_id
      t.integer :testcase_id
      t.integer :user_id
      t.string :result
      t.string :bug

      t.timestamps
    end
  end
end
