class CreateTeamrelationships < ActiveRecord::Migration
  def change
    create_table :teamrelationships do |t|
      t.integer :lead_id
      t.integer :engineer_id

      t.timestamps
    end
  end
end
