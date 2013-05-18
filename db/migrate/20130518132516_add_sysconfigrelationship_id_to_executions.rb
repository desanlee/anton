class AddSysconfigrelationshipIdToExecutions < ActiveRecord::Migration
  def change
    add_column :executions, :sysconfigrelationship_id, :integer
  end
end
