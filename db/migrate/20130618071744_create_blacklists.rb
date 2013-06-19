class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.integer :targetenv_id
      t.integer :trelationship_id
      t.integer :erelationship_id

      t.timestamps
    end
  end
end
