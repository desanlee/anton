class AddSystemIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :system_id, :integer
  end
end
