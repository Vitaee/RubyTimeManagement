class AddUserIdToTimeRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :time_records, :user_id, :integer
  end
end
