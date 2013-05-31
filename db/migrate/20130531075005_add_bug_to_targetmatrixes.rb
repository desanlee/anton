class AddBugToTargetmatrixes < ActiveRecord::Migration
  def change
    add_column :targetmatrices, :bug, :string
  end
end
