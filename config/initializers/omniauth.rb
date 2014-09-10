Rails.application.config.middleware.use OmniAuth::Builder do
    require 'openid/store/filesystem'

    provider :developer unless Rails.env.production?
    provider :openid, :store => OpenID::Store::Filesystem.new('/tmp')
    provider :raven, ENV['RAVEN_KEY'], ENV['RAVEN_SECRET'], raven_opt: {desc: "Kyuka", msg: "Kyuka needs to access your leave history"}
end
