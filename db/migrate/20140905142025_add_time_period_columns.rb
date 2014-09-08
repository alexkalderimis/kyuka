class AddTimePeriodColumns < ActiveRecord::Migration
  def up
      add_column :time_periods, :start_date, :datetime
      add_column :time_periods, :end_date, :datetime
      add_column :time_periods, :cancelled, :boolean
      add_column :time_periods, :comment, :text
  end

  def down
      remove_column :time_periods, :start_date
      remove_column :time_periods, :end_date
      remove_column :time_periods, :cancelled
      remove_column :time_periods, :comment
  end
end
