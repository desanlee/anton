class CreateTargetcaserelationships < ActiveRecord::Migration
  def change
    create_table :targetcaserelationships do |t|
      t.integer :targetcase_id
      t.integer :testcase_id

      t.timestamps
    end
  end
end
