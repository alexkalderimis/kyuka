class User < ActiveRecord::Base

    has_many :allowances
    has_many :time_periods
    has_many :authorizations
    has_and_belongs_to_many :roles
    validates :identifier, :presence => true

    def holiday_taken_in year
        year_range = Date.new(year, 1, 1) .. Date.new(year, 12, 31)
        time_periods.holiday.overlapping(year_range).reduce(0) do |total, tp|
            total + [year_range.last, tp.end_date].min.jd - [year_range.first, tp.start_date].max.jd
        end
    end

    def admin?
        roles.find_by_name('admin')
    end
end
