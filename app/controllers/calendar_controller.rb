class CalendarController < ApplicationController

    before_filter :authorize

    def show
        @day_0 = Date.new(params[:year].to_i, params[:month].to_i, 1)
        @leave = TimePeriod.overlapping(@day_0 .. (@day_0 + 1.month))
    end

    def month_params delta
        {:year => (@day_0 + delta).year, :month => (@day_0 + delta).month}
    end

    helper_method :month_params
end
