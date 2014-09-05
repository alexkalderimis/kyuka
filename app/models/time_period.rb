class TimePeriod < ActiveRecord::Base

    validates_date :start_date
    validates_date :end_date

    validates :category, inclusion: {in: %w(holiday meeting medical other)}
end
