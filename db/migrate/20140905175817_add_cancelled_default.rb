class AddCancelledDefault < ActiveRecord::Migration
  def up
      change_column :time_periods, :cancelled, :boolean, default: false
      TimePeriod.reset_column_information
      TimePeriod.where(:cancelled => nil).update_all(:cancelled => false)
  end
  def down
      change_column :time_periods, :cancelled, :boolean, default: nil
  end
end
