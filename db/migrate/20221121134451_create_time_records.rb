class CreateTimeRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :time_records do |t|
      t.text :comment
      t.string :time_type
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
