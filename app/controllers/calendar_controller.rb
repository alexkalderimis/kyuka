class CalendarController < ApplicationController

    def show
        @day_0 = Date.new(params[:year].to_i, params[:month].to_i, 1)
        @leave = TimePeriod.overlapping(@day_0, (@day_0 + 1.month))
    end
end
