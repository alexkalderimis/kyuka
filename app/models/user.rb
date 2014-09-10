class User < ActiveRecord::Base

    has_many :allowances
    has_many :time_periods
    has_many :authorizations
    has_and_belongs_to_many :roles
    validates :identifier, :presence => true

    def holiday_taken_in year
        year_range = Date.new(year, 1, 1) .. Date.new(year, 12, 31)
        bank_hols = TimePeriod.bankholiday.active.overlapping(year_range).to_a

        time_periods.active.holiday.overlapping(year_range).reduce(0) do |total, tp|
            clipped_end = [year_range.last, tp.end_date.to_date].min
            clipped_start = [year_range.first, tp.start_date.to_date].max
            r = clipped_start .. clipped_end
            holiday_discount = bank_hols.count do |h|
                r.include?(h.start_date) || r.include?(h.end_date) || (h.start_date .. h.end_date).cover?(r)
            end

            total + (clipped_end.jd - clipped_start.jd) - holiday_discount
        end

    end

    def admin?
        roles.find_by_name('admin')
    end
end
