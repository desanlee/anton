class AddExecutioncountToTaskobjects < ActiveRecord::Migration
  def change
    add_column :taskobjects, :executioncount, :integer
  end
end
