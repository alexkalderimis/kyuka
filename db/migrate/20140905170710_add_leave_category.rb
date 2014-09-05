class AddLeaveCategory < ActiveRecord::Migration
  def up
      add_column :time_periods, :category, :text, default: "holiday"
  end
  def down
      drop_column :time_periods, :category
  end
end
