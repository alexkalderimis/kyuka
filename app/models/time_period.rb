class TimePeriod < ActiveRecord::Base

    enum status: [:requested, :accepted, :rejected, :cancelled]

    validates_date :start_date
    validates_date :end_date

    validates :category, inclusion: {in: %w(holiday meeting medical other)}

    def self.overlapping(first, last)
        time_periods = TimePeriod.arel_table
        sd = time_periods[:start_date]
        ed = time_periods[:end_date]

        range_contains_start = (sd >= first) & (sd <= last)
        range_contains_end   = (ed >= first) & (ed <= last)
        period_contains_range = (sd < first) & (ed > last)

        constraint_set = range_contains_start | range_contains_end | period_contains_range
        # The AND constraints are unfortunately necessary since the Node::Grouping
        # returned by or must be wrapped in an AND node or active record will spit out
        # a where clause rather than a relation. This is soooo stupid. Not null constraints
        # were chosen to at least be useful.
        where(sd.not_eq(nil).and(ed.not_eq(nil)).and(constraint_set))
    end

    def includes(date)
        (start_date <= date) && (end_date >= date)
    end
end
