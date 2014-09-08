class AddStatusToTimePeriods < ActiveRecord::Migration
  def up
    add_column :time_periods, :status, :integer, default: 0

    TimePeriod.reset_column_information
    TimePeriod.where(cancelled: true).update_all(status: TimePeriod.statuses[:cancelled])
    TimePeriod.where(cancelled: false).update_all(status: TimePeriod.statuses[:accepted])
    remove_column :time_periods, :cancelled
  end

  def down
    add_column :time_periods, :cancelled, :boolean, default: false
    TimePeriod.reset_column_information
    TimePeriod.cancelled.update_all(cancelled: true)
    remove_column :time_periods, :status
  end
end
