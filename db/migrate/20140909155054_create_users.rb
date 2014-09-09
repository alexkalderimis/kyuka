class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.text :identifier

      t.timestamps
    end
    change_table :time_periods do |t|
      t.references :user, index: true
    end
    TimePeriod.reset_column_information
    User.reset_column_information

    admin = User.create identifier: Settings.users.admin
    TimePeriod.update_all(user_id: admin.id)
  end

  def down
    drop_table :users

    remove_column :time_periods, :user_id

  end
end
