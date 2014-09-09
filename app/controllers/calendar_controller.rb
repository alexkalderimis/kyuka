class CalendarController < ApplicationController

    before_filter :authorize

    def show
        @day_0 = Date.new(params[:year].to_i, params[:month].to_i, 1)
        range = @day_0 .. (@day_0 + 1.month)
        @leave = @current_user.time_periods.overlapping(range).active.to_a
        @leave += TimePeriod.active.overlapping(range).where(:category => TimePeriod.categories[:bankholiday])
    end

    def month_params delta
        {:year => (@day_0 + delta).year, :month => (@day_0 + delta).month}
    end

    helper_method :month_params
end
