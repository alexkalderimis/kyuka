class TimePeriodsController < ApplicationController
    extend SimpleCalendar

    has_calendar :attribute => :start_date

    def new
        @period = TimePeriod.new
    end

    def index
        @periods = {}
        TimePeriod.statuses.each do |name, value|
            @periods[name] = TimePeriod.send(name)
        end
    end

    def create
        @period = TimePeriod.new(period_params)
        if @period.save
            redirect_to @period
        else
            render 'new'
        end
    end

    def show
        @period = TimePeriod.find(params[:id])
    end

    def update
        @period = TimePeriod.find(params[:id])
        @period.update_attributes update_params
        redirect_to @period
    end

    private

    def update_params
        params.permit(:cancelled, :comment)
    end

    def period_params
        params.require(:time_period).permit(:start_date, :end_date, :comment, :category)
    end

    def search_terms
        p = params.permit(:category, :cancelled)
        if not p['cancelled'].nil?
            p['cancelled'] = p['cancelled'] == 'true'
        end
        p
    end

end
