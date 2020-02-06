class AddRoleToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :role, :string
  end
end
