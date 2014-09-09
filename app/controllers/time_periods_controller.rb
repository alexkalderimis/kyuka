class TimePeriodsController < ApplicationController
    extend SimpleCalendar

    has_calendar :attribute => :start_date

    def new
        @period = TimePeriod.new
    end

    def index
        @status = (params[:status] || :active).to_sym
        unless TimePeriod.statuses.include? @status
            flash[:info] = "Invalid status: #{ @status }"
            @status = :active
        end

        @periods = TimePeriod.send(@status)
    end

    def create
        @period = TimePeriod.new(period_params)
        if Settings.holiday.policy == 'accept'
            @period.status = :active
        end

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
        @period.save
        redirect_to @period
    end

    private

    def update_params
        if params[:status]
            {status: params[:status].to_i}
        else
            p = params.require(:time_period).permit(:comment, :start_date, :end_date, :category)
            if p[:category]
                p[:category] = TimePeriod.categories[p[:category]]
            end

            p
        end
    end

    def period_params
        params.require(:time_period).permit(:start_date, :end_date, :comment, :category)
    end

end
