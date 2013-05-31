class AddResultToTargetmatrixes < ActiveRecord::Migration
  def change
    add_column :targetmatrices, :result, :string
  end
end
