require 'set'

class PlannerController < ApplicationController

    def show
        if params[:start] and params[:end]
            @range = Date.parse(params[:start]) .. Date.parse(params[:end])
        else
            @range = (Date.current - 2.weeks) .. (Date.current + 2.weeks)
        end
        time_periods = TimePeriod.active.overlapping(@range).includes(:user)
        @users = User.joins(:roles).where(["roles.name = ?", "user"])
        @holidays = Hash.new
        @users.each do |u|
            @holidays[u.identifier] = Set.new
        end

        time_periods.each do |tp|
            hols = @holidays[tp.user.identifier]
            (tp.start_date.to_date .. tp.end_date.to_date).each do |day_off|
                hols.add day_off
            end
        end
    end
end

