class AddUpdateTimeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :update_time, :datetime
  end
end
