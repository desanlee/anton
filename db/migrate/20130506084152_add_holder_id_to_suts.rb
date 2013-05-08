class AddHolderIdToSuts < ActiveRecord::Migration
  def change
    add_column :suts, :holder_id, :integer
  end
end
