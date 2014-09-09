namespace :db do

  desc "Raise an error unless development environment"
  task :dev_only do
    raise "You can only use this in dev!" unless Rails.env == 'development'
  end
 
  desc "Drop, create, migrate then seed the development database"
  task reseed: [
    'environment', 
    'db:dev_only', 
    'db:reset', 
    'db:seed',
    'init:bankholidays'
  ]
end
