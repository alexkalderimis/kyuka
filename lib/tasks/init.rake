require 'bank_holiday'

namespace :init do

  desc "Load bank holidays into the db."
  task bankholidays: :environment do
    by_year = BankHoliday.all.group_by do |bh|
      Date.parse(bh.date).year
    end
    admin_user = User.find_or_create_by(identifier: Settings.users.admin)
    by_year.each do |year, hols|
      year_range = Date.new(year, 1, 1) .. Date.new(year, 12, 31)
      puts "==> Updating holidays for #{ year }"
      ActiveRecord::Base.transaction do
        TimePeriod.bankholiday.where(start_date: year_range).
                               update_all(status: TimePeriod.statuses[:cancelled])
        hols.each do |hol|
          comment = hol.title
          if hol.notes && hol.notes != ''
            comment << " (#{ hol.notes })"
          end
          period = TimePeriod.find_or_create_by(
            start_date: Date.parse(hol.date),
            end_date: Date.parse(hol.date),
            comment: comment,
            category: TimePeriod.categories[:bankholiday]
          )
          period.user = admin_user
          period.status = :active
          raise "Error saving #{ hol }" unless period.save
        end
      end
    end
  end

end
