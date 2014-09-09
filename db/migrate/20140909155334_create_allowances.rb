class CreateAllowances < ActiveRecord::Migration
  def change
    create_table :allowances do |t|
      t.integer :year
      t.integer :max_days
      t.references :user, index: true

      t.timestamps
    end
    User.all.each do |u|
        a = Allowance.new(user: u, year: Time.now.year, max_days: Settings.holiday.default_allowance)
        a.save
    end
  end
end
