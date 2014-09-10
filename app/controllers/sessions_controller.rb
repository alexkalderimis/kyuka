class SessionsController < ApplicationController
  def new
  end

  def create
      auth = request.env['omniauth.auth']
      @authorization = Authorization.find_by_provider_and_uid(auth.provider, auth.uid)
      if @authorization
          user = @authorization.user
      else
          user = Kyuka::Services.register auth
          unless user.save
            raise "Error logging in"
          end
      end
      session[:user_id] = user.id
      redirect_to user
  end

  def destroy
      session[:user_id] = nil
      redirect_to root_path
  end

  def failure
  end
end
