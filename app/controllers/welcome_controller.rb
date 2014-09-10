class WelcomeController < ApplicationController

    def index
        @user = current_user
        redirect_to @user unless @user.nil?
    end
end
