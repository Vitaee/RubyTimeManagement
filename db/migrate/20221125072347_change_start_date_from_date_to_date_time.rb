class ChangeStartDateFromDateToDateTime < ActiveRecord::Migration[7.0]
  def change
    change_column :time_records, :start_date, :datetime
    change_column :time_records, :end_date, :datetime
  end
end
