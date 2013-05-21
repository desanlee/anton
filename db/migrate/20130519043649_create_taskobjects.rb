class CreateTaskobjects < ActiveRecord::Migration
  def change
    create_table :taskobjects do |t|
      t.string :name
      t.integer :user_id
      t.integer :task_id
      t.string :note

      t.timestamps
    end
  end
end
