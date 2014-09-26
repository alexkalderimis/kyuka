class TimePeriodsController < ApplicationController
    extend SimpleCalendar

    before_filter :authorize

    has_calendar :attribute => :start_date

    def new
        @period = @current_user.time_periods.build

        if params[:start_date]
            @period.start_date = Date.parse(params[:start_date])
        else
            @period.start_date = Time.now.to_date
        end
        if params[:end_date]
            @period.end_date = Date.parse(params[:end_date])
        else
            @period.end_date = @period.start_date + 1.week
        end

    end

    def index
        @status = (params[:status] || :active).to_sym
        unless TimePeriod.statuses.include? @status
            flash[:info] = "Invalid status: #{ @status }"
            @status = :active
        end

        @periods = @current_user.time_periods.send(@status)
    end

    def create
        @period = @current_user.time_periods.build(period_params)
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
        @period = TimePeriod.where('user_id = :uid OR category = :cat', {
            uid: @current_user.id,
            cat: TimePeriod.categories[:bankholiday]
        }).find(params[:id])
    end

    def update
        @period = @current_user.time_periods.find(params[:id])
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
