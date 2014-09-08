module CalendarHelper

    def cell_class current_date
        classes = []
        classes << 'bank-holiday' if current_date.bank_holiday?
        classes << 'weekend' if (current_date.saturday? || current_date.sunday?)
        classes.join ' '
    end

end
