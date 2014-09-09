class AddEmailToUser < ActiveRecord::Migration
  def up
      add_column :users, :email, :text
  end

  def down
      remove_column :users, :email
  end
end
