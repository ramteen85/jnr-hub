class AddUserTypeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :userType, :integer
  end
end
