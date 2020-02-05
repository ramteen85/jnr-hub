class RemoveUserTypeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :userType, :integer
  end
end
