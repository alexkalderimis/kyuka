module CalendarHelper

    def cell_class current_date
        classes = []
        classes << 'weekend' if (current_date.saturday? || current_date.sunday?)
        classes.join ' '
    end

end
