class CreateTargetenvs < ActiveRecord::Migration
  def change
    create_table :targetenvs do |t|
      t.integer :target_id
      t.string :envtype
      t.integer :envpara

      t.timestamps
    end
  end
end
