class TimePeriod < ActiveRecord::Base

    validates_date :start_date
    validates_date :end_date

    validates :category, inclusion: {in: %w(holiday meeting medical other)}

    def self.overlapping(first, last)
        range = first .. last
        where((TimePeriod[:start_date] ==  range) | (TimePeriod[:end_date] == range) | ((TimePeriod[:start_date] < first) & (TimePeriod[:end_date] > last)))
    end
end
