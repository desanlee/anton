class CreatePriviledges < ActiveRecord::Migration
  def change
    create_table :priviledges do |t|
      t.integer :user_id
      t.string :charactor

      t.timestamps
    end
  end
end
