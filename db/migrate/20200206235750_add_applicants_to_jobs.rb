class AddApplicantsToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :applicants, :integer
  end
end
