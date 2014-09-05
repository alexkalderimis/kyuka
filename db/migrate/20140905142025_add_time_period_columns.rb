class AddTimePeriodColumns < ActiveRecord::Migration
  def up
      add_column :time_periods, :start_date, :datetime
      add_column :time_periods, :end_date, :datetime
      add_column :time_periods, :cancelled, :boolean
      add_column :time_periods, :comment, :text
  end

  def down
      drop_column :time_periods, :start_date, :datetime
      drop_column :time_periods, :end_date, :datetime
      drop_column :time_periods, :cancelled, :boolean
      drop_column :time_periods, :comment, :text
  end
end
