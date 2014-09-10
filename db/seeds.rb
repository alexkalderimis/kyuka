# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

admin_user = User.find_or_create_by(identifier: 'admin')

unless admin_user.admin?
    admin_user.add_role 'admin'
end

allowance = Settings.holiday.default_allowance

%w(Anne Brenda Carol David Edgar).each do |name|
    user = User.new identifier: name
    user.email = "#{ name.downcase }@foo.com"
    (2010 .. 2020).each do |year|
        user.allowances.build year: year, max_days: allowance
    end
    user.add_role 'user'
    user.save
end

CSV.foreach('db/seeds/holidays.csv') do |row|
    user_name, start_date, end_date, comment, status = row
    user = User.find_by_identifier(user_name)
    user.time_periods.build({
        start_date: Date.parse(start_date),
        end_date: Date.parse(end_date),
        comment: comment,
        category: TimePeriod.categories[:holiday],
        status: TimePeriod.statuses[status]
    })
    user.save
end



