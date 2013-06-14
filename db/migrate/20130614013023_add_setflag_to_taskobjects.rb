class AddSetflagToTaskobjects < ActiveRecord::Migration
  def change
    add_column :taskobjects, :setflag, :string
  end
end
