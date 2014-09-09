class AllowancesController < ApplicationController

    def new
        @user = User.find(params[:user_id])
        @allowance = @user.allowances.new({
            max_days: Settings.holiday.default_allowance,
            year: Time.now.year
        })
    end

    def edit
        @user = User.find(params[:user_id])
        @allowance = @user.allowances.find params[:id]
    end

    def update
        @user = User.find(params[:user_id])
        @allowance = @user.allowances.find params[:id]
        @allowance.update_attributes creation_params
        if @allowance.save
            redirect_to @user
        else
            render 'edit'
        end
    end

    def create
        @user = User.find(params[:user_id])
        @allowance = Allowance.new(creation_params)
        @allowance.user = @user
        if @allowance.save
            redirect_to @user
        else
            render 'new'
        end
    end

    def destroy 
        Allowance.find(params[:id]).delete
        @user = User.find(params[:user_id])
        redirect_to @user
    end

    private

    def creation_params
        params.require(:allowance).permit(:year, :max_days)
    end

end
