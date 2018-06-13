class AddHappyColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :happy, :string
  end
end
