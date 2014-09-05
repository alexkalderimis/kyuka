class RemoveBadPeriods < ActiveRecord::Migration
  def up
      TimePeriod.where(:start_date => nil).delete_all
  end
end
