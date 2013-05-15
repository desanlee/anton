class CreateTargetenvrelationships < ActiveRecord::Migration
  def change
    create_table :targetenvrelationships do |t|
      t.integer :targetenv_id
      t.integer :device_id

      t.timestamps
    end
  end
end
