module Kyuka

    module Services
        
        def self.register auth
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
          user.add_role 'user'
          if Rails.env.development?
              user.add_role 'admin'
          end
          user
        end

    end
end
