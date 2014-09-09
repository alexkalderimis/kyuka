class ChangeTimePeriodsCategoryToEnum < ActiveRecord::Migration
  def up
    by_category = {}
    TimePeriod.categories.keys.each do |k|
        by_category[k] = TimePeriod.where(category: k.to_s).select(:id).to_a.map {|tp| tp.id}
    end

    remove_column :time_periods, :category
    add_column :time_periods, :category, :integer, default: 0
    TimePeriod.reset_column_information

    by_category.each do |cat, ids|
        TimePeriod.where(id: ids).update_all(category: TimePeriod.categories[cat])
    end
  end

  def down
    by_category = {}
    TimePeriod.categories.keys.each do |cat|
        by_category[cat] = TimePeriod.send(cat).select(:id).to_a.map {|tp| tp.id}
    end

    remove_column :time_periods, :category
    add_column :time_periods, :category, :text, default: "holiday"
    TimePeriod.reset_column_information

    by_category.each do |cat, ids|
        TimePeriod.where(id: ids).update_all(category: cat.to_s)
    end
  end
end
