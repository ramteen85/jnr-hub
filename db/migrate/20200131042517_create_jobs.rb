class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :company_name
      t.string :location
      t.text :description
      t.integer :salary

      t.timestamps
    end
  end
end
