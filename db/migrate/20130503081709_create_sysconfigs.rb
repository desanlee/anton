class CreateSysconfigs < ActiveRecord::Migration
  def change
    create_table :sysconfigs do |t|
      t.integer :sut_id
      t.integer :user_id
      t.integer :autoupdate

      t.timestamps
    end
  end
end
