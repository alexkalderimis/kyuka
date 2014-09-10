class SessionsController < ApplicationController
  def new
  end

  def create
      auth = request.env['omniauth.auth']
      @authorization = Authorization.find_by_provider_and_uid(auth.provider, auth.uid)
      if @authorization
          redirect_to root_path
          session[:user_id] = @authorization.user.id
      else
          if auth.provider == "raven"
            user = User.new :email => auth.uid, :identifier => auth.uid.gsub(/@.*/, '')
          elsif auth.info["email"] and auth.info["name"]
            user = User.new :email => auth.info["email"], :identifier => auth.info["name"]
          else
            raise "Error authenticating"
          end

          user.authorizations.build({
              :provider => auth.provider,
              :uid => auth.uid
          })
          user.allowances.build({
              :year => Time.now.year,
              :max_days => Settings.holiday.default_allowance
          })
          user_role = Role.find_or_create_by(name: 'user')
          user.roles << user_role
          unless user.save
            raise "Error logging in"
          end
          session[:user_id] = user.id
          redirect_to root_path
      end
  end

  def destroy
      session[:user_id] = nil
      redirect_to root_path
  end

  def failure
  end
end
