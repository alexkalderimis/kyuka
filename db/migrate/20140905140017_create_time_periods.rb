class CreateTimePeriods < ActiveRecord::Migration
  def change
    create_table :time_periods do |t|

      t.timestamps
    end
  end
end
