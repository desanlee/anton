class CreateTargetmatrices < ActiveRecord::Migration
  def change
    create_table :targetmatrices do |t|
      t.integer :targetenv_id
      t.integer :device_id
      t.integer :testcase_id
      t.integer :execution_id
      t.datetime :update_time

      t.timestamps
    end
  end
end
