class User < ActiveRecord::Base

    has_many :allowances
    has_many :time_periods
    has_and_belongs_to_many :roles
end
