class PlannerController < ApplicationController

    def show
        if params[:start] and params[:end]
            @range = Date.parse(params[:start]) .. Date.parse(params[:end])
        else
            @range = (Date.current - 2.weeks) .. (Date.current + 2.weeks)
        end
        @holidays = {}
        User.all.select{|u| u.has_role? 'user' }.each do |user|
            days_off = @range.select {|date| user.has_day_off? date }
            @holidays[user.identifier] = days_off
        end
    end
end

