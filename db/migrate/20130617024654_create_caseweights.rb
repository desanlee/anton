class CreateCaseweights < ActiveRecord::Migration
  def change
    create_table :caseweights do |t|
      t.string :name
      t.integer :user_id
      t.integer :weight
      t.string :note

      t.timestamps
    end
  end
end
