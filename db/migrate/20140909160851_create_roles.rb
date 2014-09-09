class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, limit: 32

      t.timestamps
    end

    create_table :roles_users, id: false do |t|
        t.belongs_to :user
        t.belongs_to :role
    end

    Role.reset_column_information

    admin_user = User.find_by(identifier: Settings.users.admin)
    admin_role = Role.new(name: 'admin') do |r|
        r.users << admin_user
    end
  end
end
